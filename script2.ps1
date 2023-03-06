function initializer{
    process
    {
        $user = [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent()).Identity.Name
        $currentServer = $env:COMPUTERNAME
        $fqnd = [System.Net.Dns]::GetHostByName($env:COMPUTERNAME).HostName
        #$remoteServer = $global:serverStage
        #Write-Host $remoteServer

        $User = "LA\g466991"
        $PWord = ConvertTo-SecureString -String "Chrysler.2009" -AsPlainText -Force
        $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

        #$credential = Get-Credential -Credential $user
        $session = New-PSSession -cn $fqnd -Credential $Credential -Authentication CredSSP
        Invoke-Command -Session $session -ScriptBlock $container
    }    
}


$container = {


##--Common Global Variables--##
$global:sharedSrc = '\\'
$global:backupFolder = '_publishBackUp\'
$global:inputEnvironment
$global:inputApplication

$global:tempBackupFolder = 'bkp'
$global:tempRestoreFolder = 'rst'
$global:razorApp = 'ftsnetcore'
$global:userName = $env:username
$global:arrayEnvironment = @('dev','qa','stg', 'prod', 'dr')
$global:arrayApplication = @('sexim','ftsnet','razor', 'api', 'react')
$global:arrayApplicationMustBeStopped = @('razor', 'api', 'react')
$global:arrayType = @('d','r','c') # d = Deploy | r = Rollback | c = Copy 
$global:extensionsToExclude = '*.xls', '*.xlsx', '*.pdf', 'appSettings.json', 'web.config'
$global:content = '*'
$global:maximumAgeInHours = '-72' #must be negative
$global:poolPrefix = '._fts' 
$global:poolSubfix = 'Pool'
$global:cleanSolution = $true
$global:nugetSolution = $true
$global:buildSucceded = $false


##--GIT Config--##
$global:gitPath = '\Applications\git\'
$global:gitToken = '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'
$global:gitURL = 'git.cglcloud.com/LATAM-non-SAP-apps/'
$global:appPrefix = 'fts-'
$global:msBuildPath = 'C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin'
#$global:msBuildPath = 'C:\temp'
$global:msBuildExe = '\msbuild.exe'

##C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools>

##--Servers--##
$global:serverDev = @('MSBRCAM1076')
$global:serverQA = @('MSBRCAM1076')
$global:serverStage = @('MSBRCAM1081')
$global:serverProd = @('MSBRCAM1081', 'MSBRCAM1081', 'MSBRCAM1081') #@('MSBRCAMP153', 'MSBRCAMP154', 'MSBRCAMP155')
$global:serverDr = @('MSBRCAM1081')
#$global:allFtsServers = @('MSBRCAM1076', 'MSBRCAM1081','MSBRCAMP153', 'MSBRCAMP154', 'MSBRCAMP155','MSBRCAM1046')
#$global:qa = 'MSBRCAM1081'

##--FtsFolderNames--##
#$global:ftsDevSite = '\Applications\_ftsDevSite\'
#$global:ftsQaSite = '\Applications\_ftsQaSite\'
#$global:ftsStageSite = '\Applications\_ftsStageSite\'
#$global:ftsProdSite = '\Applications\_ftsSite\'
#$global:ftsDrSite = '\Applications\_ftsDrSite\'
$global:ftsDevSite = '\Applications\_ftsSiteAutomaticDeploy\'
$global:ftsQaSite = '\Applications\_ftsSiteAutomaticDeploy\'
$global:ftsStageSite = '\Applications\_ftsSiteAutomaticDeploy\'
$global:ftsProdSite = '\Applications\_ftsSiteAutomaticDeploy\'
$global:ftsDrSite = '\Applications\_ftsSiteAutomaticDeploy\'

##--FtsFrontEndApp--##
$global:ftsDevFrontEndApp = '\Applications\_ftsDevFrontEndApp\'
$global:ftsQaFrontEndApp = '\Applications\_ftsQaFrontEndApp\'
$global:ftsStageFrontEndApp = '\Applications\_ftsStageFrontEndApp\'
$global:ftsProdFrontEndApp = '\Applications\_FtsApp\'
$global:ftsDrFrontEndApp = '\Applications\_FtsApp\FtsReactDr\'

##--FtsPoolNames--##
$global:ftsApiPool = 'Api'
$global:ftsFrontEndAppPool = 'FrontEndApp'
$global:ftsRazorAppPool = 'NetCore'
$global:ftsApiCakTrade = 'ApiCakTrade'
$global:ftsCaeWsPool = 'CaeWs'
$global:ftsNetPool = 'Net'
$global:ftsSeximPool = 'Sexim'

##--FtsSolutionNames--##
$global:SLN_FtsSexim = 'sexim.sln'
$global:SLN_FtsNet = 'FTSNET.sln'
$global:SLN_FtsNetCore = 'FTSNETCORE.sln'
$global:SLN_FTSApiCakTrade = 'ApiTrade.sln'

##--FtsProjectNames--##
$global:VBP_FtsSexim = 'sexim.vbproj'
$global:VBP_FtsNet = 'FTSWeb\FTSWeb.vbproj'
$global:CSP_FtsApi = 'Cargill.FTS.WebAPI\Cargill.FTS.WebAPI.csproj'
$global:CSP_FtsRazor = 'Cargill.FTS.Web\Cargill.FTS.Web.csproj'
$global:CSP_FtsReact = 'Cargill.FTS.React\Cargill.FTS.React.csproj'
$global:CSP_FTSApiCakTrade = 'ApiTrade.sln'


##--FtsPublishProfiles--##
$global:PubProfile_FtsSexim = 'fts-sexim-deploy-profile'
$global:PubProfile_FtsNet = 'fts-net-deploy-profile'
$global:PubProfile_FtsRazor = 'fts-razor-deploy-profile'
$global:PubProfile_FtsApi = 'fts-api-deploy-profile'
$global:PubProfile_FtsReact = 'fts-react-deploy-profile'
$global:PubProfile_FTSApiCakTrade = 'fts-api-trade-profile'

##--FtsPublishPlatforms--##
$global:PubPlatforms_AnyCPU = 'Any CPU'
$global:PubPlatforms_MixedPlatform = 'Mixed Platforms'
$global:PubPlatforms_x86 = 'x86'
$global:PubPlatforms_x64 = 'x64'

##--FtsOutputPath--##
$global:Output_FtsSexim = '\release'
$global:Output_FtsNet = '\release'
$global:Output_FtsRazor = '\Cargill.FTS.Web\release'
$global:Output_FtsApi = '\Cargill.FTS.WebAPI\release'
$global:Output_FtsReact = '\Cargill.FTS.React\ClientApp'
$global:Output_FTSApiCakTrade = '\release\apitrade'


##---------------------------##
##--External Main Functions--##
##---------------------------##

function deploy-fts
{
    ShowProcess('Running...-> deploy-fts')
}

function rollback-fts
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> rollback-fts')
        $server
        $ftsName
        $ftsFrontEnd
        $isValidEnvironment = IsValidEnvironment($environment)
        $isValidApplication = IsValidApplication($application)

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT to restore'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            return
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION to restore'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $server = GetServer $environment
        $ftsName = GetFtsSite $environment
        $ftsFrontEnd = GetFrontEnd $environment
        $application = GetApplication $application

        Foreach($srv in $server){
            if ($application.ToLower() -eq 'razor') { $application = $global:razorApp }

            $backupPath = $global:sharedSrc + $srv + $ftsName + $global:backupFolder + $application
            $backUpName

            Set-Location $backupPath

            $ArrayZipFiles = Get-ChildItem -Filter "*.zip" | Sort-Object LastWriteTime -Descending

            if ($ArrayZipFiles.Count -gt 1){
                $(for($i=0; $i -lt $ArrayZipFiles.Count; $i++){
                    [PSCustomObject]@{
                        'File Name'       = "${i}: $($ArrayZipFiles.BaseName[$i])"
                        'Last Write Time' = $ArrayZipFiles.LastWriteTime[$i]
                            }
                        }) | Out-Host

                $input = Read-Host -Prompt "Select a backup from the list"
                ShowProcess("You have just selected: $($ArrayZipFiles[$input])")
                $backUpName = $ArrayZipFiles[$input]

            }
            elseif ($ArrayZipFiles.Count -eq 1){
                $backUpName = $ArrayZipFiles[0]
            }
            else{
                ShowError("There aren´t backup´s to recover")
                return
            }
            $destinationPath = $backupPath + '\' + $global:tempRestoreFolder
            $backupPath = $backupPath + '\' + $backUpName
        
            UnZipBackup $backupPath $backUpName $destinationPath $environment $srv $application
             
        }
        return
    }
}

function backup-fts
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        
        $isValidEnvironment = IsValidEnvironment($environment)
        $isValidApplication = IsValidApplication($application)
        Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT to deploy'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            return
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION to deploy'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $server = GetServer $environment
        $ftsName = GetFtsSite $environment
        $ftsFrontEnd = GetFrontEnd $environment
        $application = GetApplication $application

        Foreach($srv in $server){
            if ($application.ToLower() -eq 'react') { 
                $originPath = $global:sharedSrc + $srv + $ftsFrontEnd
            }
            else{
                $originPath = $global:sharedSrc + $srv + $ftsName + $application 
            }

            $backupPath = $global:sharedSrc + $srv + $ftsName + $backupFolder + $application + '\'
            $timeStamp = Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
            $backupName = $application + '-' + $timeStamp + '-' + $global:userName +"-bkp.zip"

            ZipBackup $backupPath $backupName $originPath $environment $srv $application
        }
        
        return
    }
}

##---------------------------##
##--Internal Main Functions--##
##---------------------------##

function build-fts
{
    param
    (

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application,

        [parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [String] $nuget,

        [parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [String] $clean

    )
    process
    {
        ShowProcess('Running...-> build-fts')
        $isValidEnvironment = IsValidEnvironment($environment)
        $isValidApplication = IsValidApplication($application)

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            return
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $msBuild = $global:msBuildPath  + $global:msBuildExe
        $pathToBuild = GetSolutionPathAndNameToBuild $environment $application
        $publishProf = GetSolutionPublishProfile $application
        $server = GetServer $environment 
        $gitRepo = GetGitRepository $application
        $platformBuild = GetSolutionPlatformBuild $application
        $outputPath = GetOutputPath $environment $application
        
        Switch ($application.toLower())
        {
            {$_ -in 'sexim','ftsnet'}   {

                        if ($nuget) {
                            Write-Host "Restoring NuGet packages" -foregroundcolor green
                            $pathToGetPackages = $global:sharedSrc + $server + $global:gitPath + $gitRepo
                            ShowProcess($pathToGetPackages)
                            Set-Location $pathToGetPackages
                            nuget restore
                        }

                        if ($clean) {
                            Write-Host "Cleaning $($pathToBuild)" -foregroundcolor green
                            & "$($msBuild)" "$($pathToBuild)" /t:Clean /m
                        }
                        
                        Write-Host "Building $($pathToBuild)" -foregroundcolor green
                         & "$($msBuild)" "$($pathToBuild)" /p:Configuration=Release /p:OutputPath=$outputPath /p:Platform=$platformBuild /p:DeployOnBuild=true
                        break
                    }
            
            {$_ -in 'api','razor'}   {
                        Write-Host "Building $($pathToBuild)" -foregroundcolor green
                        dotnet publish $pathToBuild -c Release --output $outputPath #-r win-x64 
                        break
                    }

            {$_ -in 'react'}   {
                        Write-Host "Building $($pathToBuild)" -foregroundcolor green
                        $clientApp = $global:sharedSrc + $server + $global:gitPath + $gitRepo + $global:Output_FtsReact
                        Set-Location $clientApp
                        npm run build
                        break
                    }
            default {
                        Echo 'You must enter an APPLICATION to build'
                        break
                        return
                    }
        }

        if( -not $? ){
            $msg = $Error[0]
            $returnMessage = "Encountered error during building. Please check solution and try again."
            ShowError($returnMessage)
            $global:buildSucceded = $false
        }
        else{
            ShowSuccess("Successfull build, ready to deploy.")
            $global:buildSucceded = $true
        }

        return $global:buildSucceded

        #msbuild $pathToBuild /p:DeployOnBuild=true /p:PublishProfile=$publishProf
        #SEXIM -> /p:PublishProfile=$publishProf /p:Configuration=Release #/p:Platform="Any CPU" #/p:DeployOnBuild=true
        #/p:PublishProfile=$publishProf



        #\\MSBRCAM1076\Applications\git\fts-net\release\_PublishedWebsites\FTSWeb\
    }
}

function stop-fts
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> stop-fts')
        $isValidEnvironment = IsValidEnvironment($environment)
        $isValidApplication = IsValidApplication($application)
        Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT to stop'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            return
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION to stop'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $server = GetServer $environment
        $appPool = GetPoolIIS $environment $application

        Foreach($srv in $server){
            if ($global:arrayApplicationMustBeStopped -ceq $application.toLower()) { 
                Invoke-Command -ComputerName $srv -ScriptBlock {
                    param($srv, $appPool)
                        Stop-WebAppPool -Name $appPool
                } -ArgumentList $srv, $appPool
                ShowSuccess('IIS AppPool -> ' + $appPool + ' on ' + $srv + ' server, was successfully stopped')
            }
        }
    }
    
}

function start-fts
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> start-fts')
        $isValidEnvironment = IsValidEnvironment($environment)
        $isValidApplication = IsValidApplication($application)
        Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT to start'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            return
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION to start'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $server = GetServer $environment
        $appPool = GetPoolIIS $environment $application

        Foreach($srv in $server){
            if ($global:arrayApplicationMustBeStopped -ceq $application.toLower()) { 
                Invoke-Command -ComputerName $srv -ScriptBlock {
                    param($srv, $appPool)
                        Start-WebAppPool -Name $appPool
                } -ArgumentList $srv, $appPool
                ShowSuccess('IIS AppPool -> ' + $appPool + ' on ' + $srv + ' server, was successfully started')
            }
        }
    }
}

function log-fts
{
    ShowProcess('Running...-> log-fts')
}

function replace-fts
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $type
    )
    process
    {
        ShowProcess('Running...-> replace-fts')
        $sourcePath
        $destinationPath
        $isValidEnvironment = IsValidEnvironment($environment)
        $isValidApplication = IsValidApplication($application)
        $isValidType = IsValidType($type)

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT to restore'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            return
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION to restore'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        if (-not $isValidType) {
            $msg = 'You must enter a valid TYPE to make the copy/paste operation'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayType + ' | d = Deploy | r = Rollback | c = Copy ')
            
            return
        }

        $server = GetServer $environment
        $ftsName = GetFtsSite $environment
        $ftsFrontEnd = GetFrontEnd $environment
        $gitRepo = GetGitRepository $application
        
        Foreach($srv in $server){
            if ($application.ToLower() -eq 'razor') { $application = $global:razorApp }

            if ($application.ToLower() -eq 'react') { 
                $destinationPath = $global:sharedSrc + $srv + $ftsFrontEnd
            }
            else{
                $destinationPath = $global:sharedSrc + $srv + $ftsName + $application 
            }

            Switch ($type.toLower())
            {
                'd'   {
                            $sourcePath = $global:sharedSrc + $srv + $ftsName + $global:backupFolder + $application + $global:tempRestoreFolder + '\'
                            #$destinationPath = $global:sharedSrc + $srv + $ftsName + $application
                            break
                      }
            
                'r'   {
                            $sourcePath = $global:sharedSrc + $srv + $ftsName + $global:backupFolder + $application + '\' + $global:tempRestoreFolder
                            #$destinationPath = $global:sharedSrc + $srv + $ftsName + $application
                            break
                      }

                'c'   {
                            $sourcePath = $global:sharedSrc + $srv + $ftsName + $global:backupFolder + $application
                            #$destinationPath = $global:sharedSrc + $srv + $ftsName + $backupFolder + $application
                            break
                      }
            
            }

            $files = Get-ChildItem -Path $sourcePath -Exclude $global:extensionsToExclude

            ShowProcess('Transferring files to ' + $destinationPath)

            Foreach($file in $files){
                Copy-Item -Path $file -Destination $destinationPath -Exclude $global:extensionsToExclude -Recurse -Force
            }

            ShowSuccess('Transfer process completed')
            CleanDirectory $sourcePath
        }
        return
    }
}

function git-glv
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> git-glv')
        $isValidEnvironment = IsValidEnvironment($environment)
        $isValidApplication = IsValidApplication($application)

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT to checkout'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            return
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION to checkout'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $server = GetServer $environment
        $ftsName = GetFtsSite $environment
        $ftsFrontEnd = GetFrontEnd $environment
        $gitRepo = GetGitRepository $application

        if ($server.count -gt 1){
            $server = $server[0]
        }
        
        $env:GIT_REDIRECT_STDERR = '2>&1'
        $url = 'https://' + $global:gitToken + '@' + $global:gitURL + $gitRepo + '.git'
        $absoluteGitPath = $global:sharedSrc + $server + $global:gitPath + $gitRepo
        $relativeGitPath = $global:sharedSrc + $server + $global:gitPath

        GetPath $relativeGitPath
        #ShowSuccess('relativeGitPath -> ' + $relativeGitPath)
        Set-Location $relativeGitPath
        $isGitRepo = git rev-parse --is-inside-work-tree
        $gitBranch = GetGitBranch $environment
        
        if($isGitRepo){
           
            $filesInDirectory = (Get-ChildItem $absoluteGitPath -ErrorAction SilentlyContinue).Count 
            #ShowProcess($filesInDirectory)
           
            if ($filesInDirectory -eq 0){
                #ShowError('CLONE')
                git clone $url
            }
            #ShowSuccess('Folder de destino -> ' + $relativeGitPath)
            #ShowError('CheckOut en -> ' + $absoluteGitPath)
            Set-Location $absoluteGitPath
            git fetch --all
            git checkout $gitBranch
            git pull
        }
        return
    }
}

function get-config
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> get-config')
        $isValidEnvironment = IsValidEnvironment($environment)
        $isValidApplication = IsValidApplication($application)

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            return
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $global:inputEnvironment = $environment
        $global:inputApplication = $application
        return $true
    }
}

##--------------------##
##--Common Functions--##
##--------------------##

function ZipClean
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [String] $path

        
    )
    process
    {
        Set-Location $path
        $ArrayZipFiles = Get-ChildItem -Filter "*.zip" | Sort-Object LastWriteTime -Descending
        
        if ($ArrayZipFiles.Count -gt 1){
            $(for($i=0; $i -lt $ArrayZipFiles.Count; $i++){
                
                $datediff = [datetime]$ArrayZipFiles.LastWriteTime[$i]
                $today = Get-Date
                $oldestBackupDate = $today.AddHours($global:maximumAgeInHours)
                          
                if([datetime]$ArrayZipFiles.LastWriteTime[$i] -lt $oldestBackupDate){
                    
                    $fileToDelete = $path + $ArrayZipFiles.BaseName[$i] + '.zip'
                    ShowProcess('Deleting old file:' + $fileToDelete)
                    CleanDirectory($fileToDelete)
                }

            })

            ShowSuccess('Cleaning process completed')
        }
    }    
}

function ZipBackup
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $backupPath,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $backupName,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $originPath,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $server,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        $msg = 'Creating BACKUP file for ***' + $environment.toUpper() + '*** environment on ' + $server.toUpper() + ' server of ***' + $application.toUpper() + '*** application named as -> ' + $backupName
        ShowProcess($msg)
        
        GetPath $originPath
        
        $tempOriginPath = $originPath
        GetPath $tempOriginPath
        $tempOriginPath = $tempOriginPath + '\*'
        
        $tempBackupPath = $backupPath + $global:tempBackupFolder
        GetPath $tempBackupPath

        Copy-Item -Path $tempOriginPath -Destination $tempBackupPath -Exclude $global:extensionsToExclude -Recurse -Force
        $file = Get-ChildItem -Path $tempBackupPath -Exclude $global:extensionsToExclude

        $compress = @{
            Path = $file
            CompressionLevel = "Fastest"
            DestinationPath = $backupPath + $backupName
        }
        Compress-Archive @compress
        CleanDirectory $tempBackupPath
        ZipClean $backupPath
        ShowSuccess('Backup process completed')
        return
    }
}

function UnZipBackup
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $backupPath,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $backupName,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $destinationPath,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $server,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        $msg = 'Expanding backup file for ***' + $environment.toUpper() + '*** environment on ' + $server + ' server of ***' + $application.toUpper() + '*** app named as -> ' + $backupName
        ShowProcess($msg)
        Expand-Archive -LiteralPath $backupPath -DestinationPath $destinationPath -Force
        ShowSuccess('Expand process completed')
        return
    }
    
}

function CleanDirectory
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $path
    )
    process
    {
        Remove-Item -Path $path -recurse -force
    }
}

function GetPath
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $path
    )
    process
    {
        If(!(test-path -PathType container $path))
            {
                  New-Item -ItemType Directory -Path $path
            }
        }
}

function IsValidEnvironment
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment
    )
    process
    {
        $returnValue = $false

        if ($environment -ne '' -and $global:arrayEnvironment -ceq $environment.toLower()){
            $returnValue = $true
        }
        return $returnValue
    }
}

function IsValidApplication
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        $returnValue = $false
        if ($application -ne '' -and $global:arrayApplication -ceq $application.toLower()){
            $returnValue = $true
        }
        return $returnValue
    }
}

function IsValidType
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $type
    )
    process
    {
        $returnValue = $false
        if ($type -ne '' -and $global:arrayType -ceq $type.toLower()){
            $returnValue = $true
        }
        return $returnValue
    }
}

function ShowError
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $message
    )
    process
    {
        Write-Host $message -foregroundcolor red  
    }
}

function ShowSuccess
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $message
    )
    process
    {
        Write-Host $message -foregroundcolor green  
    }
}

function ShowWarning
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $message
    )
    process
    {
        Write-Host $message -foregroundcolor yellow  
    }
}

function ShowProcess
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $message
    )
    process
    {
        Write-Host $message -foregroundcolor cyan  
    }
}

function GetFtsSite
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment
    )
    process
    {
        ShowProcess('Running...-> GetFtsSite')
        Switch ($environment.toLower())
        {
            'dev'   {
                        $site = $global:ftsDevSite
                        break
                    }
            
            'qa'    {
                        $site = $global:ftsQaSite
                        break
                    }

            'stg'   {
                        $site = $global:ftsStageSite
                        break
                    }

            'prod'  {
                        $site = $global:ftsProdSite
                        break
                    }

            'dr'   {
                        $site = $global:ftsDrSite
                        break
                    }

            default {
                        Echo 'You must enter an ENVIRONMENT to deploy'
                        break
                    }
        }

        return $site
    }
}

function GetFrontEnd
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment
    )
    process
    {
        ShowProcess('Running...-> GetFrontEnd')
        Switch ($environment.toLower())
        {
            'dev'   {
                        $ftsFrontEnd = $global:ftsDevFrontEndApp
                        break
                    }
            
            'qa'    {
                        $ftsFrontEnd = $global:ftsQaFrontEndApp
                        break
                    }

            'stg'   {
                        $ftsFrontEnd = $global:ftsStageFrontEndApp
                        break
                    }

            'prod'  {
                        $ftsFrontEnd = $global:ftsProdFrontEndApp
                        break
                    }

            'dr'   {
                        $ftsFrontEnd = $global:ftsDrFrontEndApp
                        break
                    }

            default {
                        Echo 'You must enter an ENVIRONMENT to deploy'
                        break
                    }
        }

        return $ftsFrontEnd
    }
}

function GetPoolIIS
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> GetPoolIIS')
        Switch ($environment.toLower())
        {
            'dev'   {
                        $ftsPool = $global:poolPrefix + 'Dev'
                        break
                    }
            
            'qa'    {
                        $ftsPool = $global:poolPrefix + 'Qa'
                        break
                    }

            'stg'   {
                        $ftsPool = $global:poolPrefix + 'Stage'
                        break
                    }

            'prod'  {
                        $ftsPool = $global:poolPrefix
                        break
                    }

            'dr'    {
                        $ftsPool = $global:poolPrefix + 'Dr'
                        break
                    }

            default {
                        Echo 'You must enter an ENVIRONMENT'
                        break
                    }
        }

        Switch ($application.toLower())
        {
            'razor' {
                        $ftsPool = $ftsPool + $global:ftsRazorAppPool + $global:poolSubfix
                        break
                    }

            'api'   {
                        $ftsPool = $ftsPool + $global:ftsApiPool + $global:poolSubfix
                        break
                    }

            'react'   {
                        $ftsPool = $ftsPool + $global:ftsFrontEndAppPool + $global:poolSubfix
                        break
                    }

            default {
                        Echo 'You must enter an APPLICATION'
                        break
                    }
        }

        return $ftsPool
    }
}

function GetServer
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment
    )
    process
    {
        ShowProcess('Running...-> GetServer')
        Switch ($environment.toLower())
        {
            'dev'   {
                        $server = $global:serverDev
                        break
                    }
            
            'qa'    {
                        $server = $global:serverQa
                        break
                    }

            'stg'   {
                        $server = $global:serverStage
                        break
                    }

            'prod'  {
                        $server = $global:serverProd
                        break
                    }

            'dr'   {
                        $server = $global:serverDr
                        break
                    }

            default {
                        Echo 'You must enter an ENVIRONMENT to deploy'
                        break
                    }
        }
        
        return $server
    }
}

function GetApplication
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> GetApplication')
        if ($application.ToLower() -eq 'razor') { $application = $global:razorApp }
        return $application
    }
}

function GetGitRepository
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> GetGitRepository')
        Switch ($application.toLower())
        {
            'sexim'   {
                        $repo = $global:appPrefix + 'sexim'
                        break
                    }
            
            'ftsnet'    {
                        $repo = $global:appPrefix + 'net'
                        break
                    }

            {$_ -in 'api','razor','react'}   {
                        $repo = $global:appPrefix + 'netcore'
                        break
                    }
            default {
                        Echo 'You must enter an APPLICATION to checkout'
                        break
                    }
        }
        
        return $repo
    }
}

function GetSolutionPathAndNameToBuild
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> GetSolutionPathToBuild')
        $isValidApplication = IsValidApplication($application)
        $isValidEnvironment = IsValidEnvironment($environment)

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            return
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $server = GetServer $environment
        $gitRepo = GetGitRepository $application

        Switch ($application.toLower())
        {
            'sexim'   {
                        $solutionName = $global:SLN_FtsSexim
                        break
                    }
            
            'ftsnet'    {
                        $solutionName = $global:SLN_FtsNet
                        break
                    }

            'tradeapi'    {
                        $solutionName = $global:SLN_FTSApiCakTrade
                        break
                    }
             
            'api'    {
                        $solutionName = $global:CSP_FtsApi
                        break
                    }

            'razor'    {
                        $solutionName = $global:CSP_FtsRazor
                        break
                    }
            'react'    {
                        $solutionName = $global:SLN_FTSReact
                        break
                    }
             
            default {
                        Echo 'You must enter an APPLICATION to checkout'
                        break
                    }
        }



        #$global:VBP_FtsSexim = 'sexim.vbproj'
        #$global:VBP_FtsNet = 'FTSWeb\FTSWeb.vbproj'
        #$global:CSP_FtsApi = 'Cargill.FTS.WebAPI\Cargill.FTS.WebAPI.csproj'
        #$global:CSP_FtsRazor = 'Cargill.FTS.Web\Cargill.FTS.Web.csproj'
        #$global:CSP_FtsReact = 'Cargill.FTS.React\Cargill.FTS.React.csproj'
        #$global:CSP_FTSApiCakTrade = 'ApiTrade.sln'
        
        $absolutePathToBuild = $global:sharedSrc + $server + $global:gitPath + $gitRepo + '\' +  $solutionName
        $relativeGitPath = $global:sharedSrc + $server + $global:gitPath + '\' +  $solutionName

        ShowProcess('Absolute Path To Build -> ' + $absolutePathToBuild)
        return $absolutePathToBuild
    }
}

function GetOutputPath
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> GetSolutionPath')
        $isValidApplication = IsValidApplication($application)
        $isValidEnvironment = IsValidEnvironment($environment)

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            r
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $server = GetServer $environment
        $gitRepo = GetGitRepository $application

        Switch ($application.toLower())
        {
            'sexim'   {
                        $relativeOutputPath = $global:Output_FtsSexim
                        break
                    }
            
            'ftsnet'    {
                        $relativeOutputPath = $global:Output_FtsNet
                        break
                    }

            'razor'    {
                        $relativeOutputPath = $global:Output_FtsRazor
                        break
                    }

            'api'    {
                        $relativeOutputPath = $global:Output_FtsApi
                        break
                    }
            
            'react'    {
                        $relativeOutputPath = $global:Output_FtsReact
                        break
                    }

            'tradeapi'    {
                        $relativeOutputPath = $global:Output_FTSApiCakTrade
                        break
                    }
            
            default {
                        Echo 'You must enter an APPLICATION'
                        break
                    }
        }
        
        $outputPath = $global:sharedSrc + $server + $global:gitPath + $gitRepo + $relativeOutputPath

        ShowProcess('OutputPath -> ' + $outputPath)
        return $outputPath
    }
}

function GetBuildPath
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment,

        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> GetBuildPath')
        $isValidApplication = IsValidApplication($application)
        $isValidEnvironment = IsValidEnvironment($environment)

        if (-not $isValidEnvironment) {
            $msg = 'You must enter a valid ENVIRONMENT'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayEnvironment)
            
            r
        }

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        $server = GetServer $environment
        $gitRepo = GetGitRepository $application

        Switch ($application.toLower())
        {
            'sexim'   {
                        $relativeOutputPath = $global:Output_FtsSexim
                        break
                    }
            
            'ftsnet'    {
                        $relativeOutputPath = $global:Output_FtsNet
                        break
                    }

            'razor'    {
                        $relativeOutputPath = $global:Output_FtsRazor
                        break
                    }

            'api'    {
                        $relativeOutputPath = $global:Output_FtsApi
                        break
                    }
            
            'react'    {
                        $relativeOutputPath = $global:Output_FtsReact
                        break
                    }

            'tradeapi'    {
                        $relativeOutputPath = $global:Output_FTSApiCakTrade
                        break
                    }
            
            default {
                        Echo 'You must enter an APPLICATION'
                        break
                    }
        }
        
        $outputPath = $global:sharedSrc + $server + $global:gitPath + $gitRepo + $relativeOutputPath

        ShowProcess('OutputPath -> ' + $outputPath)
        return $outputPath
    }
}

function GetSolutionPublishProfile
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> GetSolutionPublishProfile')
        $isValidApplication = IsValidApplication($application)

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        Switch ($application.toLower())
        {
            'sexim'   {
                        $profile = $global:PubProfile_FtsSexim
                        break
                    }
            
            'ftsnet'    {
                        $profile = $global:PubProfile_FtsNet
                        break
                    }

            'razor'    {
                        $profile = $global:PubProfile_FtsRazor
                        break
                    }

            'api'    {
                        $profile = $global:PubProfile_FtsApi
                        break
                    }
            
            'react'    {
                        $profile = $global:PubProfile_FtsReact
                        break
                    }

            'tradeapi'    {
                        $profile = $global:PubProfile_FTSApiCakTrade
                        break
                    }
            
            default {
                        Echo 'You must enter an APPLICATION'
                        break
                    }
        }
        
        ShowProcess('Publish Profile -> ' + $profile)
        return $profile
    }
}

function GetSolutionPlatformBuild
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $application
    )
    process
    {
        ShowProcess('Running...-> GetSolutionPlatformBuild')
        $isValidApplication = IsValidApplication($application)

        #$global:PubPlatforms_AnyCPU = 'Any CPU'
        #$global:PubPlatforms_MixedPlatform = 'Mixed Platform'
        #$global:PubPlatforms_x86 = 'x86'
        #$global:PubPlatforms_x64 = 'x64'

        if (-not $isValidApplication) {
            $msg = 'You must enter a valid APPLICATION'
            ShowWarning($msg)
            ShowWarning('|| Suggestions -> ' + $global:arrayApplication)
            
            return
        }

        Switch ($application.toLower())
        {
            'sexim'   {
                        $platform = $global:PubPlatforms_AnyCPU
                        break
                    }
            
            'ftsnet'    {
                        $platform = $global:PubPlatforms_x86
                        break
                    }

            'razor'    {
                        $platform = $global:PubProfile_FtsRazor
                        break
                    }

            'api'    {
                        $platform = $global:PubProfile_FtsApi
                        break
                    }
            
            'react'    {
                        $platform = $global:PubProfile_FtsReact
                        break
                    }

            'tradeapi'    {
                        $platform = $global:PubProfile_FTSApiCakTrade
                        break
                    }
            
            default {
                        Echo 'You must enter an APPLICATION'
                        break
                    }
        }
        
        ShowProcess('Publish platform -> ' + $platform)
        return $platform
    }
}

function GetGitBranch
{
    param
    (
        [parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [String] $environment
    )
    process
    {
        ShowProcess('Running...-> GetGitBranch')
        Switch ($environment.toLower())
        {
            'dev'   {
                        $branch = 'develop2'
                        break
                    }
            
            'qa'    {
                        $branch = 'qa'
                        break
                    }

            'stg'   {
                        $branch = 'stage'
                        break
                    }

            'prod'  {
                        $branch = 'master'
                        break
                    }

            default {
                        Echo 'You must enter an ENVIRONMENT to get the correct branch'
                        break
                    }
        }
        
        return $branch
    }
}

function IsNpmInstalled
{
    process
    {
        $returnValue = $false
        if ($application -ne '' -and $global:arrayApplication -ceq $application.toLower()){
            $returnValue = $true
        }
        return $returnValue
    }
}

##--------------------##
##-------START--------##
##-----Container------##
##---Execution Zone---##
##--------------------##


    $readyToGo = get-config

    if ($readyToGo) {
        ShowSuccess('Ready to go!')
        ShowProcess('$global:inputEnvironment -> ' + $global:inputEnvironment)
        ShowProcess('$global:inputApplication -> ' + $global:inputApplication)
        
        #$global:cleanSolution = $true
        #$global:nugetSolution = $true
        
        #backup-fts $global:inputEnvironment $global:inputApplication
        #rollback-fts $global:inputEnvironment $global:inputApplication
        #replace-fts $global:inputEnvironment $global:inputApplication
        git-glv $global:inputEnvironment $global:inputApplication
        #stop-fts $global:inputEnvironment $global:inputApplication
        #start-fts $global:inputEnvironment $global:inputApplication
        build-fts $global:inputEnvironment $global:inputApplication $global:nugetSolution $global:cleanSolution
    }
    else{
        ShowError('Process stopped. Something went wrong during execution start. Please check')
        return
    }

##--------------------##
##--------END---------##
##-----Container------##
##---Execution Zone---##
##--------------------##


}

#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#

##-----AUTO-START-----## -> Auto execution on Start

initializer 

##--------------------##


