$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$module = 'DragonSlayer'

$path = "$here"

Describe -Tags ('Unit', 'Acceptance') "$module Module Tests" {

    Context 'Module Setup' {
        It "has the root module $module.psm1" -TestCases @{ path = $path; module = $module } {
            param(
                [string] $path,
                [string] $module
            )
            "$path\$module.psm1" | Should -Exist
        }

        It "has the manifest file of $module.psd1" -TestCases @{ path = $path; module = $module } {
            param(
                [string] $path,
                [string] $module
            )
            "$path\$module.psd1" | Should -Exist
            "$path\$module.psd1" | Should -FileContentMatch "$module.psm1"
        }

        It "$module is valid PowerShell code" -TestCases @{ path = $path; module = $module } {
            param(
                [string] $path,
                [string] $module
            )
            $psFile = Get-Content -Path "$path\$module.psm1" -ErrorAction Stop
            $errors = $null
            [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
            $errors.Count | Should -Be 0
        }
    }
}
