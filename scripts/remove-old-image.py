"""

This script is based on this documentation: 
https://docs.github.com/en/rest/packages/packages?apiVersion=2022-11-28

"""

import os
import requests
from requests.auth import HTTPBasicAuth

# Delete the old container (based on the previous tag)
def delete_old_image(version_id, org, headers, auth):
    url_delete_previous_version = f"https://api.github.com/orgs/{org}/packages/container/{container_name}/versions/{version_id}"
    response = requests.delete(url_delete_previous_version, headers=headers, auth=auth)
    if response.status_code == 204:
        print(f'Previous container deleted!')
    else:
        print('error deleting the previous container:', response.status_code, response.text)
        exit(1)
    
# Find the previous tag for a specific container
def find_previous_container_tag(response, pr_tag):
    version_id = None
    for version in response:
        tags = version['metadata']['container']['tags']
        if pr_tag not in tags and tags:
            version_id = version['id']
            print(f"Previous tag found {tags[0]} with version_id {version_id}")
            return tags[0], version_id

    print(f"Container name {container_name} not found or the only tag found was the current one. If that is the case, you can ignore this error.")
    exit(0)

# Get all GCR container information
def get_container_tags(org, container_name, auth, headers, container_path):
    get_versions = f"https://api.github.com/orgs/{org}/packages/container/{container_name}/versions"
    response = requests.get(get_versions, headers=headers, auth=auth)
    try:
        response.raise_for_status()
    except requests.exceptions.HTTPError as e:
        print(f"Error getting the previous tag for the container {container_path} : {e}")
        exit(1)
    
    return response

def print_console(message):
    print("====================================")
    print(message)
    
if __name__ == "__main__":
    registry = os.getenv("REGISTRY")
    github_token = os.getenv("GITHUB_TOKEN")
    container_name = os.getenv("CONTAINER_NAME")
    pr_tag = os.getenv("PR_TAG")
    user = os.getenv("USER")
    current_commit = os.getenv("CURRENT_COMMIT")

    headers = {
        "Accept": "application/vnd.github.v3+json",
    }
    auth = HTTPBasicAuth(user, github_token)

    container_path = f"{registry}/{container_name}:{pr_tag}"
    org = registry.split("/")[1]

    print_console(f"Getting all tags for this container {container_path}...")
    response = get_container_tags(org, container_name, auth, headers, container_path)
    print("Done!")

    print_console(f"Looking for the previous tag...")
    previous_tag, version_id = find_previous_container_tag(response.json(), pr_tag)
    print("Done!")

    print_console(f"Deleting the previous container with tag ({previous_tag}) and version_id {version_id}...")
    delete_old_image(version_id, org, headers, auth)
    print("Done!")
