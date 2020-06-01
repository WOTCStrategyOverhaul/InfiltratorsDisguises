class IDHelpers extends Object abstract;

static function bool IsDLCLoaded (name DLCName)
{
    local XComOnlineEventMgr EventManager;
    local int                Index;
	
	if (DLCName == '')
		return true;

    EventManager = `ONLINEEVENTMGR;
	
    for (Index = 0; Index < EventManager.GetNumDLC(); Index++)    
    {
        if(EventManager.GetDLCNames(Index) == DLCName)    
        {
            return true;
        }
    }

    return false;
}
