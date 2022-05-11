# Project Self-Destruct

When this function is invoked, it shuts down the project it's deployed in. It should go without saying, but **BE CAREFUL**—while this *is* in fact a toy, **it is a very dangerous one**, and not at all intended for production or serious use. If you're using this in a project with critical services, calling it could have serious and irreversible consequences!

## Why?

Deleting projects when certain conditions are met, such as going over a billing threshold or reaching an autodestruct deadline, is a useful way to manage costs and complexity. It can be reassuring, for example, to know a project running heavy duty GPU workloads will be deleted before the fees can get too far out of hand.

## Deployment

To deploy this function to a new project:

1. Install `toys`, if you haven't already.
2. Run `toys zip` to generate a zip of the function's source files.
3. Create a `terraform.tfvars` file in the terraform directory based on the spec below.
4. Run `terraform apply` (probably after a `terraform plan`) to create a self-destructable project.

Now you can use cloud scheduler, for example, to set a time to invoke the self-destruct feature for this project, or call the function directly with the `gcloud functions call` command.

## Initiating self-destruct

To call, pass `projectToDelete` param that is equal to the project you want to delete, e.g.

```console
$ gcloud functions call self-destruct --data='{"projectToDelete":"theselfdestructprojectname"}'
```

## Terraform variables

|Variable|Description|Required|
-|-|-
|project|The name of the project you want to create.|REQUIRED|
|folder_id|The parent folder for the new project.|REQUIRED|
|billing_account|The billing account to associate to the project.|REQUIRED|
|region|The region to deploy the function to. Defaults to `us-west`||
