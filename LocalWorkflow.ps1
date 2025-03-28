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
            -var 'subscription_id=[subscription_id]' `
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
            -var 'subscription_id=[subscription_id]'
    }
    finally
    {
        Set-Location $currentLocation
    }
}

CreateResourceGroup $environmentName
CreateNetwork $environmentName
