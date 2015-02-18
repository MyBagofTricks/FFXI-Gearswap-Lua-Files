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

end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal','Acc','SuperAcc')
	state.RangedMode:options('Normal')
	state.HybridMode:options('Normal')
	state.WeaponskillMode:options('Normal')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')

    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')	
	
	
	
	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()

end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Sets to apply to arbitrary JAs
	sets.precast.JA['No Foot Rise'] = {}
	
	-- Sets to apply to any actions of spell.type
	sets.precast.Waltz = {}
		
	-- Sets for specific actions within spell.type
	sets.precast.Waltz['Healing Waltz'] = {}

    -- Sets for fast cast gear for spells
	sets.precast.FC = {ear2="Loquacious Earring"}

    -- Fast cast gear for specific spells or spell maps
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Weaponskill sets
	sets.precast.WS = {ammo="Yetshila",
	head="Otomi Helm",neck=gear.ElementalGorget,ear1="Brutal Earring",ear2="Moonshade Earring",
	body="Mes. Haubergeon",hands="Miki. Gauntlets",ring1="Karieyh Ring",ring2="Ifrit Ring",
	back="Mauler's Mantle",waist=gear.ElementalBelt,legs="Agoge Cuisses",feet="Rvg. Calligae +2"}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {head="Yaoyotl Helm",hands="Xaddi Gloves"})
	
	-- Specific weaponskill sets.
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {ammo="Ravager's Orb"})
	sets.precast.WS['Ukko\'s Fury'] = set_combine(sets.precast.WS, {body="Phorcys Korazin",ammo="Ravager's Orb"})
	
	sets.WSDayBonus = {head="Gavialis Helm"}
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------

    -- Generic spell recast set
	sets.midcast.FastRecast = {head="Otomi Helm",body="Xaddi Mail",hands="Cizin Mufflers +1",
							waist="Phos Belt",legs="Cizin Breeches +2",feet="Ejekamal Boots"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {head="Otomi Helm",body="Xaddi Mail",hands="Cizin Mufflers +1",
							waist="Phos Belt",legs="Cizin Breeches +2",feet="Ejekamal Boots"}

	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	
	-- Resting sets
	sets.resting = {neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring"}
	

	-- Idle sets
	--sets.idle = {}

	sets.idle.Town = {main="Ragnarok", sub="Pole Grip",ammo="Yetshila",
		head="Goblin Coif",neck="Wiglen Gorget",ear1="Brutal Earring",ear2="Trux Earring",
		body="Mes. Haubergeon",hands="Cizin Mufflers +1",ring1="Karieyh Ring",ring2="Paguroidea Ring",
		back="Repulse Mantle",waist="Flume Belt +1",legs="Agoge Cuisses",feet="Hermes' Sandals"}

    sets.idle.Field = {ammo="Yetshila",
		head="Goblin Coif",neck="Wiglen Gorget",ear1="Brutal Earring",ear2="Trux Earring",
		body="Mes. Haubergeon",hands="Cizin Mufflers +1",ring1="Karieyh Ring",ring2="Paguroidea Ring",
		back="Repulse Mantle",waist="Flume Belt +1",legs="Agoge Cuisses",feet="Hermes Sandals"}

		
	sets.idle.Weak = {ammo="Yetshila",
		head="Twilight Helm",neck="Wiglen Gorget",ear1="Brutal Earring",ear2="Trux Earring",
		body="Twilight Mail",hands="Cizin Mufflers +1",ring1="Karieyh Ring",ring2="Paguroidea Ring",
		back="Repulse Mantle",waist="Flume Belt +1",legs="Agoge Cuisses",feet="Ejekamal Boots"}
	
	-- Defense sets
	sets.defense.PDT = {
        head="Ogier's Helm",neck="Twilight Torque",ear1="Black Earring",ear2="Black Earring",
        body="Mekira Meikogai",ring1="Dark Ring",ring2="Dark Ring",
        back="Repulse Mantle",waist="Flume Belt +1"}

    sets.defense.Reraise = {ammo="Angha Gem",
        head="Twilight Helm",neck="Twilight Torque",ear1="Black Earring",ear2="Black Earring",
        body="Twilight Mail",ring1="Dark Ring",ring2="Dark Ring",
        back="Repulse Mantle",waist="Nierenschutz"}
	
	
	
	sets.defense.MDT = {ammo="Sihirik",
        head="Ogier's Helm",neck="Twilight Torque",
        body="Mekira Meikogai",ring1="Dark Ring",ring2="Dark Ring",
        back="Repulse Mantle",waist="Nierenschutz"}

    -- Gear to wear for kiting
	sets.Kiting = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Yetshila",
	head="Otomi Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Trux Earring",
	body="Mes. Haubergeon",hands="Cizin Mufflers +1",ring1="Rajas Ring",ring2="K'ayres Ring",
	back="Mauler's Mantle",waist="Windbuffet Belt +1",legs="Agoge Cuisses",feet="Ejekamal Boots"}

	sets.engaged.Acc = {ammo="Yetshila",
	head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
	body="Mes. Haubergeon",hands="Cizin Mufflers +1",ring1="Rajas Ring",ring2="K'ayres Ring",
	back="Mauler's Mantle",waist="Windbuffet Belt",legs="Agoge Cuisses",feet="Ejekamal Boots"}

	sets.engaged.SuperAcc = {ammo="Yetshila",
	head="Yaoyotl Helm",neck="Iqabi Necklace",ear1="Zennaroi Earring",ear2="Steelflash Earring",
	body="Mes. Haubergeon",hands="Cizin Mufflers +1",ring1="Rajas Ring",ring2="Mars's Ring",
	back="Mauler's Mantle",waist="Olseni Belt",legs="Cizin Breeches +1",feet="Ejekamal Boots"}
	
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	--sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {hands="Orion Bracers +1"})
	--sets.buff.Camouflage = {body="Orion Jerkin +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
		if is_sc_element_today(spell) then
			equip(sets.WSDayBonus)
		end
	end

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end

-- Called when a generally-handled state value has been changed.
function job_state_change(stateField, newValue, oldValue)

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	return meleeSet
end

-- Modify the default defense set after it was constructed.
function customize_defense_set(defenseSet)
	return defenseSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

-- Job-specific toggles.
function job_toggle_state(field)

end

-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_option_modes(field)

end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_option_mode(field, val)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 8)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 8)
	elseif player.sub_job == 'SAM' then
		set_macro_page(2, 8)
	else
		set_macro_page(5, 8)
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
