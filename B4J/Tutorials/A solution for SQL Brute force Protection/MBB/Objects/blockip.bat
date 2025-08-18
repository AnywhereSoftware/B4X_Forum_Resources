netsh ipsec static add filter filterlist=MBB_%1 srcaddr=%2 dstaddr=Me 
netsh ipsec static add filteraction name=MBB_ACTIONFOR_%1 action=block
netsh ipsec static add policy name=MBB_POL_1 assign=yes
netsh ipsec static add rule name=MBB_%1 policy=MBB_POL_1 filterlist=MBB_%1 filteraction=MBB_ACTIONFOR_%1 activate=yes