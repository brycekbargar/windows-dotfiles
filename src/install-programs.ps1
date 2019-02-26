Write-Host "Ensuring programs are installed" -ForegroundColor DarkCyan

$core = @(
    [PSCustomObject]@{ name = "flux";
        env = "home";
        type = "host";
    },
    [PSCustomObject]@{ name = "discord";
        env = "home";
        type = "host";
    },
    [PSCustomObject]@{ name = "slack";
        env = "milyli";
        type = "host";
    },
    [PSCustomObject]@{ name = "windirstat";
        env = $null;
        type = "guest";
    }
)

$dev = @(
    [PSCustomObject]@{ name = "nvm";
        env = $null;
        type = "guest";
    },
    [PSCustomObject]@{ name = "dotnet-sdk";
        env = "milyli";
        type = "guest";
    },
    [PSCustomObject]@{ name = "postgresql";
        env = "home";
        type = "guest";
    },
    [PSCustomObject]@{ name = "heroku-cli";
        env = "home";
        type = "guest";
    }
)

($core + $dev)|
    Where-Object {
        ($null -eq $_.env -or $env:InstallEnv -eq $_.env) -and 
        ($null -eq $_.type -or $env:InstallType -eq $_.type)
    } |
    ForEach-Object {
            & scoop install $_.name
            & scoop update $_.name
    }

Write-Host "Programs are installed" -ForegroundColor DarkCyan