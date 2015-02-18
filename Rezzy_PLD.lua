-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Cab. Breeches"}
    sets.precast.JA['Holy Circle'] = {feet="Rev. Leggings"}
    sets.precast.JA['Shield Bash'] = {hands="Vlr. Gauntlets +2"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet"}
    sets.precast.JA['Fealty'] = {body="Cab. Surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +1"}
    sets.precast.JA['Cover'] = {head="Rev. Coronet +1"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        head="Rev. Coronet +1",
        body="Reverence Surcoat",hands="Rev. Gauntlets +1",ring1="Balrahn's Ring",
        back="Weard Mantle",legs="Rev. Breeches",feet="Rev. Leggings"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Rev. Coronet +1",
        hands="Rev. Gauntlets +1",ring2="Kunaji Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Rev. Breeches",feet="Rev. Leggings"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Tarutaru Sash"}
    sets.precast.Flourish1 = {waist="Tarutaru Sash"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Incantor Stone",
        head="Cizin Helm +1",ear1="Hospitaler Earring",ear2="Loquacious Earring",
		body="Reverence Surcoat",hands="Rev. Gauntlets +1",ring1="Dark Ring",
		waist="Flume Belt +1",legs="Enif Cosciales",feet="Phorcys Schuhs"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Jukukik Feather",
        head="Otomi Helm",neck=gear.ElementalGorget,ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Mes. Haubergeon",hands="Cizin Mufflers +1",ring1="Karieyh Ring",ring2="Ifrit Ring",
        back="Atheling Mantle",waist=gear.ElementalBelt,legs="Miki. Cuisses",feet="Whirlpool Greaves"}

    sets.precast.WS.Acc = {ammo="Jukukik Feather",
        head="Yaoyotl Helm",neck=gear.ElementalGorget,ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Mes. Haubergeon",hands="Buremte Gloves",ring1="Karieyh Ring",ring2="Ifrit Ring",
        back="Weard Mantle",waist=gear.ElementalBelt,legs="Miki. Cuisses",feet="Whirlpool Greaves"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {hands="Buremte Gloves",waist="Zoran's Belt"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {hands="Buremte Gloves",waist="Zoran's Belt"})

    sets.precast.WS['Sanguine Blade'] = {
        head="Rev. Coronet +1",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Cab. Surcoat +1",hands="Rev. Gauntlets +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Toro Cape",waist="Caudata Belt",legs="Rev. Breeches",feet="Rev. Leggings"}
    
    sets.precast.WS['Atonement'] = {ammo="Jukukik Feather",
        head="Rev. Coronet +1",neck=gear.ElementalGorget,ear1="Creed Earring",ear2="Steelflash Earring",
        body="Reverence Surcoat",hands="Rev. Gauntlets +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist=gear.ElementalBelt,legs="Rev. Breeches",feet="Rev. Leggings"}
    
	sets.WSDayBonus = {head="Gavialis Helm"}   
	
	--------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Rev. Coronet +1",
        body="Reverence Surcoat",hands="Rev. Gauntlets +1",
        waist="Zoran's Belt",legs="Enif Cosciales",feet="Rev. Leggings"}
        
    sets.midcast.Enmity = {
        head="Rev. Coronet +1",neck="Invidia Torque",
        body="Reverence Surcoat",hands="Rev. Gauntlets +1",ring1="Vexer Ring",
        waist="Creed Baudrier",legs="Cab. Breeches",feet="Creed Sabatons +1"}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {legs="Enif Cosciales"})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {ammo="Aqua Sachet",
        head="Rev. Coronet +1",neck="Phalaina Locket",ear1="Hospitaler Earring",ear2="Lifestorm Earring",
        body="Reverence Surcoat",hands="Buremte Gloves",ring1="Kunaji Ring",ring2="Vexer Ring",
        back="Weard Mantle",waist="Creed Baudrier",legs="Rev. Breeches",feet="Rev. Leggings"}

    sets.midcast['Enhancing Magic'] = {legs="Rev. Breeches"}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Creed Collar",ear1="Relaxing Earring",
        head="Ogier's Helm",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Ogier's Breeches"}
    

    -- Idle sets
    sets.idle = {ammo="Angha Gem",
        head="Rev. Coronet +1",neck="Creed Collar",ear1="Brutal Earring",ear2="Trux Earring",
        body="Cab. Surcoat +1",hands="Rev. Gauntlets +1",ring1="Karieyh Ring",ring2="Paguroidea Ring",
        back="Weard Mantle",waist="Flume Belt +1",legs="Rev. Breeches",feet="Rev. Leggings"}

    sets.idle.Town = {main="Usonmunku",sub="Ochain",ammo="Angha Gem",
        head="Goblin Coif",neck="Creed Collar",ear1="Brutal Earring",ear2="Trux Earring",
        body="Mes. Haubergeon",hands="Rev. Gauntlets +1",ring1="Karieyh Ring",ring2="Paguroidea Ring",
        back="Weard Mantle",waist="Flume Belt +1",legs="Rev. Breeches",feet="Rev. Leggings"}
    
    sets.idle.Weak = {ammo="Angha Gem",
        head="Rev. Coronet +1",neck="Creed Collar",ear1="Black Earring",ear2="Black Earring",
        body="Cab. Surcoat +1",hands="Rev. Gauntlets +1",ring1="Karieyh Ring",ring2="Paguroidea Ring",
        back="Weard Mantle",waist="Flume Belt +1",legs="Rev. Breeches",feet="Rev. Leggings"}
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {}

    sets.latent_refresh = {waist="Fucho-no-Obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {neck="Creed Collar",waist="Flume Belt +1"}
    sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt +1",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Buramenk'ah",sub="Ochain"} -- Ochain
    sets.MagicalShield = {main="Buramenk'ah",sub="Weather. Shield +1"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {ammo="Angha Gem",
        head="Rev. Coronet +1",neck="Wiglen Gorget",ear1="Black Earring",ear2="Black Earring",
        body="Cab. Surcoat +1",hands="Umuthi Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Rev. Breeches",feet="Rev. Leggings"}
    sets.defense.HP = {ammo="Angha Gem",
        head="Rev. Coronet +1",neck="Twilight Torque",ear1="Black Earring",ear2="Ethereal Earring",
        body="Cab. Surcoat +1",hands="Umuthi Gloves",ring1="Dark Ring",ring2="Dark Ring",
        back="Weard Mantle",waist="Creed Baudrier",legs="Rev. Breeches",feet="Rev. Leggings"}
    sets.defense.Reraise = {ammo="Angha Gem",
        head="Twilight Helm",neck="Twilight Torque",ear1="Black Earring",ear2="Ethereal Earring",
        body="Twilight Mail",hands="Umuthi Gloves",ring1="Dark Ring",ring2="Dark Ring",
        back="Weard Mantle",waist="Nierenschutz",legs="Rev. Breeches",feet="Rev. Leggings"}
    sets.defense.Charm = {ammo="Angha Gem",
        head="Rev. Coronet +1",neck="Twilight Torque",ear1="Black Earring",ear2="Ethereal Earring",
        body="Twilight Mail",hands="Rev. Gauntlets +1",ring1="Dark Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Flume Belt +1",legs="Rev. Breeches",feet="Rev. Leggings"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {ammo="Angha Gem",
        head="Rev. Coronet +1",neck="Twilight Torque",ear1="Black Earring",ear2="Ethereal Earring",
        body="Cab. Surcoat +1",hands="Rev. Gauntlets +1",ring1="Dark Ring",ring2="Shadow Ring",
        back="Weard Mantle",waist="Creed Baudrier",legs="Rev. Breeches",feet="Whirlpool Greaves"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {ammo="Jukukik Feather",
        head="Otomi Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Trux Earring",
        body="Mes. Haubergeon",hands="Cizin Mufflers +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Windbuffet Belt +1",legs="Cizin Breeches +1",feet="Ejekamal Boots"}

    sets.engaged.Acc = {ammo="Jukukik Feather",
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Trux Earring",
        body="Mes. Haubergeon",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Weard Mantle",waist="Phasmida Belt",legs="Cizin Breeches +1",feet="Whirlpool Greaves"}

    sets.engaged.DW = {ammo="Jukukik Feather",
        head="Otomi Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Trux Earring",
        body="Mes. Haubergeon",hands="Cizin Mufflers +1",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Windbuffet Belt +1",legs="Cizin Breeches +1",feet="Ejekamal Boots"}

    sets.engaged.DW.Acc = {ammo="Jukukik Feather",
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Trux Earring",
        body="Mes. Haubergeon",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Weard Mantle",waist="Phasmida Belt",legs="Cizin Breeches +1",feet="Whirlpool Greaves"}

    sets.engaged.PDT = set_combine(sets.engaged, {ammo="Angha Gem",
	head="Rev. Coronet +1",neck="Twilight Torque",ear2="Ethereal Earring",
	body="Cab. Surcoat +1",ring1="Dark Ring",ring2="Dark Ring",
	back="Shadow Mantle",waist="Flume Belt +1",legs="Rev. Breeches",feet="Rev. Leggings"})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {ammo="Angha Gem",
	head="Yaoyotl Helm",neck="Twilight Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",
	body="Cab. Surcoat +1",hands="Buremte Gloves",ring1="Mars's Ring",ring2="Dark Ring",
	back="Weard Mantle",waist="Phos Belt",legs="Cizin Breeches +1",feet="Rev. Leggings"})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {ammo="Angha Gem",
	head="Rev. Coronet +1",neck="Twilight Torque",ear1="Brutal Earring",ear2="Ethereal Earring",
	body="Reverence Surcoat",hands="Cizin Mufflers",ring2="Dark Ring",
	back="Shadow Mantle",waist="Flume Belt +1",legs="Rev. Breeches",feet="Rev. Leggings"})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {ammo="Jukukik Feather",
	head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
	body="Reverence Surcoat",hands="Buremte Gloves",ring1="Mars's Ring",ring2="Dark Ring",
	back="Weard Mantle",waist="Phos Belt",legs="Cizin Breeches",feet="Rev. Leggings"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {}
    sets.buff.Cover = {head="Rev. Coronet +1", body="Cab. Surcoat +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 3)
    else
        set_macro_page(1, 3)
    end
end

function is_sc_element_today(spell)
    if spell.type ~= 'WeaponSkill' then
        return
    end
   
    local weaponskill_elements = S{}:
        union(skillchain_elements[spell.skillchain_a]):
        union(skillchain_elements[spell.skillchain_b]):
        union(skillchain_elements[spell.skillchain_c])

    if weaponskill_elements:contains(world.day_element) then
        return true
    else
        return false
    end
end