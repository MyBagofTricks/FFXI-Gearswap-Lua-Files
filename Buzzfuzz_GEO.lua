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
    indi_timer = ''
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    gear.default.weaponskill_waist = "Windbuffet Belt"

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic"}

    -- Fast cast sets for spells

    sets.precast.FC = {
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Loquacious Earring",ear2="Enchntr. Earring +1",
		ring1="Prolix Ring",ring2="Weather. Ring",
        back="Swith Cape",waist="Witful Belt",legs="Geomancy Pants"}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Genbu's Shield",back="Pahtli Cape"})

    --sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		--main="Ngqoqwanb",sub="Zuuxowu Grip",
		--head="Hagondes Hat +1", neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		--body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Balrahn's Ring",ring2="Strendu Ring",
		--back="Toro Cape",legs="Hagondes Pants +1",feet="Hag. Sabots +1"})

    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        hands="Yaoyotl Gloves",ring1="Rajas Ring",
        back="Refraction Cape",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {ammo="Dosis Tathlum",
        head="Hagondes Hat +1",neck="Eddy Necklace",ear1="Friomisi Earring",
        body="Hagondes Coat +1",hands="Yaoyotl Gloves",ring1="Balrahn's Ring",ring2="Strendu Ring",
        back="Toro Cape",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}

    sets.precast.WS['Starlight'] = {}

    sets.precast.WS['Moonlight'] = {}


    --------------------------------------
    -- Midcast sets
    --------------------------------------
	
	
    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear1="Loquacious Earring",ear2="Enchntr. Earring +1",
        body="Hagondes Coat +1",hands="Bokwus Gloves",ring2="Weather. Ring",
        waist="Witful Belt",legs="Geomancy Pants",feet="Hag. Sabots"}

    sets.midcast.Geomancy = {range="Dunna",
		head="Nares Cap",ear1="Gifted Earring",ear2="Gwati Earring",
		body="Bagua Tunic",hands="Geomancy Mitaines",
		back="Lifestream Cape",waist="Austerity Belt"}
    sets.midcast.Geomancy.Indi = {range="Dunna",
		head="Nares Cap",ear1="Gifted Earring",
		body="Bagua Tunic",hands="Geomancy Mitaines",
		back="Lifestream Cape",waist="Austerity Belt",legs="Bagua Pants"}

    sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Clarus Stone",
        head="Kaabnax Hat",neck="Colossus's Torque",ear1="Lifestorm Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tempered Cape",waist="Bishop's Sash",legs="Nares Trews",feet="Uk'uxkaj Boots"}
    
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {ring1="Sheltered Ring"}

    sets.midcast.Shellra = {ring1="Sheltered Ring"}

	
	sets.midcast['Elemental Magic'] = {
		main="Ngqoqwanb",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Hagondes Hat +1", neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Strendu Ring",ring2="Balrahn's Ring",
		back="Toro Cape",wasist="Cognition Belt",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}
	
    sets.midcast['Dark Magic'] = {main="Ngqoqwanb", 
        head="Kaabnax Hat",neck="Eddy Necklace",ear1="Gwati Earring",ear2="Enchntr. Earring +1",
        body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Sangoma Ring",ring2="Weather. Ring",
        back="Lifestream Cape",waist="Demonry Sash",legs="Mes'yohi Slacks",feet="Uk'uxkaj Boots"}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {head="Bagua Galero"})
	sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], {head="Bagua Galero"})
	sets.midcast.Fire = set_combine(sets.midcast['Elemental Magic'], {waist="Chaac Belt"})	

    sets.midcast.MndEnfeebles = {main="Ngqoqwanb", sub="Mephitis Grip",
        head="Kaabnax Hat",neck="Eddy Necklace",ear1="Gwati Earring",ear2="Enchntr. Earring +1",
        body="Hagondes Coat +1",hands="Otomi Gloves",ring1="Sangoma Ring",ring2="Weather. Ring",
        back="Lifestream Cape",waist="Demonry Sash",legs="Mes'yohi Slacks",feet="Uk'uxkaj Boots"}

    sets.midcast.IntEnfeebles = {main="Ngqoqwanb", sub="Mephitis Grip",
        head="Kaabnax Hat",neck="Eddy Necklace",ear1="Gwati Earring",ear2="Enchntr. Earring +1",
        body="Hagondes Coat +1",hands="Otomi Gloves",ring1="Sangoma Ring",ring2="Weather. Ring",
        back="Lifestream Cape",waist="Demonry Sash",legs="Mes'yohi Slacks",feet="Uk'uxkaj Boots"}	
	
    sets.midcast.Stun = {main="Apamajas I",sub="Arbuda Grip",ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear1="Gwati Earring",ear2="Enchntr. Earring +1",
        body="Hagondes Coat +1",hands="Hagondes Cuffs +1",ring1="Prolix Ring",ring2="Weather. Ring",
        back="Kumbira Cape",waist="Ninurta's Sash",legs="Artsieq Hose",feet="Hag. Sabots +1"}

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {main="Ngqoqwanb",neck="Eddy Necklace"})	


	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {main="Bolelabunga",sub="Genbu's Shield",head="Nefer Khat",neck="Twilight Torque",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist="Austerity Belt",legs="Nares Trews"}


    -- Idle sets

    sets.idle = {main="Bolelabunga", sub="Genbu's Shield",range="Dunna",
        head="Nefer Khat",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Heka's Kalasiris",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist="Fucho-no-obi",legs="Nares Trews",feet="Herald's Gaiters"}

    sets.idle.PDT = {main="Terra's Staff",sub="Oneiros Grip",range="Dunna",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Geomancy Tunic",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Fucho-no-obi",legs="Nares Trews",feet="Hag. Sabots +1"}

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Terra's Staff",sub="Oneiros Grip",range="Dunna",
        head="Geomancy Galero",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Geomancy Tunic",hands="Geomancy Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Fucho-no-obi",legs="Nares Trews",feet="Bagua Sandals"}

    sets.idle.PDT.Pet = {main="Terra's Staff",sub="Oneiros Grip",range="Dunna",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Geomancy Tunic",hands="Geomancy Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Fucho-no-obi",legs="Nares Trews",feet="Bagua Sandals"}

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

    sets.idle.Town = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Geomancy Tunic",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist="Fucho-no-obi",legs="Nares Trews",feet="Geomancy Sandals"}

    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",range="Dunna",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Geomancy Tunic",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist="Fucho-no-obi",legs="Nares Trews",feet="Geomancy Sandals"}

    -- Defense sets

    sets.defense.PDT = {main="Terra's Staff",sub="Oneiros Grip",range="Dunna",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Fucho-no-obi",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}

    sets.defense.MDT = {main="Terra's Staff",sub="Oneiros Grip",range="Dunna",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Moonshade Earring",
        body="Hagondes Coat +1",hands="Bagua Mitaines",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Fucho-no-obi",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {range="Dunna",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Enchntr. Earring +1",
        body="Hagondes Coat +1",hands="Bokwus Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Witful Belt",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 6)
end