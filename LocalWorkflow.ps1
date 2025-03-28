using namespace System.IO

param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet("dev", "prod")]
    [string]
    $environmentName
)

function CreateResourceGroup([string] $environmentName)
{
    $currentLocation = $(Get-Location)
    $resourceGroupLocation = [Path]::Combine($currentLocation, "resource_group", "environments", $environmentName)

    try
    {
        Set-Location $resourceGroupLocation
        terraform fmt -check -recursive
        terraform init
        terraform validate

        terraform apply -auto-approve `
            -var 'application_name=terraapp1' `
            -var 'subscription_id=e14fb840-981f-4a3d-a81b-5c460951de8c' `
            -var 'location=North Europe'
    }
    finally
    {
        Set-Location $currentLocation
    }
}

function CreateNetwork([string] $environmentName)
{
    $currentLocation = $(Get-Location)
    $networkLocation = [Path]::Combine($currentLocation, "network", "environments", $environmentName)

    try
    {
        Set-Location $networkLocation
        terraform fmt -check -recursive
        terraform init
        terraform validate

        terraform apply -auto-approve `
            -var 'application_name=terraapp1' `
            -var 'subscription_id=e14fb840-981f-4a3d-a81b-5c460951de8c'
    }
    finally
    {
        Set-Location $currentLocation
    }
}

CreateResourceGroup $environmentName
CreateNetwork $environmentName
