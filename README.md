# istioctl Resource for Concourse

Use [istioctl](https://istio.io/docs/reference/commands/istioctl) from [Concourse](https://concourse.ci/).

## Installing

Add the resource type to your pipeline:

```yaml
resource_types:
- name: istioctl
  type: docker-image
  source:
    repository: yoshiyuki/concourse-istioctl-resource
```

## Source Configuration
* `cluster_url`: *Required.* URL to Kubernetes Master API service
* `cluster_ca`: *Optional.* Base64 encoded PEM. Required if `cluster_url` is https.
* `token`: *Optional.* Bearer token for Kubernetes.  This, 'token_path' or `admin_key`/`admin_cert` are required if `cluster_url` is https.
* `token_path`: *Optional.* Path to file containing the bearer token for Kubernetes.  This, 'token' or `admin_key`/`admin_cert` are required if `cluster_url` is https.
* `admin_key`: *Optional.* Base64 encoded PEM. Required if `cluster_url` is https and no `token` or 'token_path' is provided.
* `admin_cert`: *Optional.* Base64 encoded PEM. Required if `cluster_url` is https and no `token` or 'token_path' is provided.

## Behavior
### `check`: Check for new releases

Any new revisions to the release are returned, no matter their current state. The release must be specified in the
source for `check` to work.

### `in`: Not Supported

### `out`: Deploy the istio resource

Deploys istio configuration onto the Kubernetes cluster. Istio must be already installed
on the cluster.

#### Parameters
* `configurations`: *Required.* list of istio configuration. A `path` to config file is required for each item.
  * `path`: path to config file
* `delete`: *Optional.* set if to delete deployment corresponding to the configuration

## Example

### Out

Define the resource:

```yaml
resources:
- name: istio-deploy
  type: istioctl
  source:
    cluster_url: https://kube-master.domain.example
    cluster_ca: _base64 encoded CA pem_
    admin_key: _base64 encoded key pem_
    admin_cert: _base64 encoded certificate pem_
```

Add to job:

```yaml
jobs:
  # ...
  plan:
  - put: istio-deploy
    params:
      configurations:
      - path: path/to/istio-config.yaml
```
