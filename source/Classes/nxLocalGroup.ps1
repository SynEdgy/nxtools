class nxLocalGroup
{
    hidden static $GroupEntryParser = '^(?<groupname>[^:]+):(?<pwd>[^:]*):(?<gid>[\d]+):(?<members>.*)$'
    [string]    $GroupName
    [string]    $Password
    [int]       $GroupId
    [string[]]  $GroupMember

    nxLocalGroup()
    {
        # default ctor
    }

    nxLocalGroup([string]$GroupEntry)
    {
        Write-Debug -Message "[nxLocalGroup] Parsing '$_'."
        if ($groupEntry -notmatch [nxLocalGroup]::GroupEntryParser)
        {
            throw "Unrecognized Group entry from /etc/group with '($GroupEntry)'."
        }
        else
        {
            $this.GroupName = $Matches.groupname
            $this.Password  = $Matches.pwd
            $this.GroupId   = [int]::Parse($Matches.gid)
            $this.GroupMember = $Matches.members -split ','
        }
    }
}
