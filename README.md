# AnyGun2Akimbo (Modded Weapons Project)
Original by Dr. Newbie http://modwork.shop/21295

Current Issues: 

- Some weapons have missing/missaligned parts either in preview (some fix themselves when using them during heists) or both in preview and in-game; can see what parts are misaligned/"missing" on Proving Grounds map as they are palced dead center in front of you on the ground
- Coming across crashes for some custom weapons (any help would be appreciated); sometimes happens from either trying to mod the weapon or trying to attach a mod to a weapon (so far noticable with mainly AMCAR-style/based custom weapons)


Crashlog is as follows-


Application has crashed: C++ exception
...es/weaponfactorymanager_caching/weaponfactorymanager.lua:68: attempt to concatenate local 'part_id' (a nil value)



SCRIPT STACK

_preload_part() lib/managers/weaponfactorymanager.lua:350
_preload_part() lib/managers/weaponfactorymanager.lua:364
preload_blueprint() lib/managers/weaponfactorymanager.lua:288
preload_weapon_blueprint() lib/managers/blackmarketmanager.lua:2032
view_weapon() lib/managers/blackmarketmanager.lua:5132
_start_crafting_weapon() lib/managers/menu/blackmarketgui.lua:12753
original() lib/managers/menu/blackmarketgui.lua:12366
choose_weapon_mods_callback() @mods/base/req/core/Hooks.lua:188
callback() lib/managers/menu/blackmarketgui.lua:12152
first_btn_callback() lib/managers/menu/blackmarketgui.lua:12582
press_first_btn() lib/managers/menu/blackmarketgui.lua:7062
BlackMarketGui_mouse_double_click_original() lib/managers/menu/blackmarketgui.lua:6969
mouse_double_click() @mods/WolfHUD-master/lua/MenuTweaks.lua:344
mouse_double_click() lib/managers/menu/menurenderer.lua:413
lib/managers/mousepointermanager.lua:381


-------------------------------

Callstack:

         payday2_win32_release  (???)     ???                                                 
         payday2_win32_release  (???)     ???                                                 
         payday2_win32_release  (???)     ???                                                 
         payday2_win32_release  (???)     zip_get_name                                        
                         ntdll  (???)     RtlAllocateHeap                                     


-------------------------------

Current thread: Main

-------------------------------
