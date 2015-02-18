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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main=gear.FastcastStaff,ammo="Incantor Stone",
        neck="Orison Locket",ear1="Loquac. Earring",ear2="Enchntr. Earring +1",
        hands="Gende. Gages +1",ring1="Prolix Ring",ring2="Weather. Ring",
        back="Swith Cape",waist="Witful Belt"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Orsn. Pantaln. +2"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {main="Tamaxchi",sub="Genbu's Shield",
		head="Gende. Caubeen +1",body="Heka's Kalasiris",
		back="Pahtli Cape",feet="Cure Clogs"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {
        head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Refraction Cape",waist=gear.ElementalBelt,legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    sets.precast.WS['Flash Nova'] = {
        head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {ammo="Incantor Stone",
        ear1="Loquacious Earring",ear2="Enchntr. Earring +1",
        hands="Gende. Gages +1",
        waist="Ninurta's Sash",back="Swith Cape",feet="Gendewitha Galoshes"}
    
    -- Cure sets
    gear.default.obi_waist = "Bishop's Sash"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.CureSolace = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor Stone",
        head="Gende. Caubeen +1",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Orison Earring",
        body="Orison Bliaud +2",hands="Bokwus Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tempered Cape",waist=gear.ElementalObi,legs="Orsn. Pantaloons +2",feet="Orvail Souliers"}

    sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor Stone",
        head="Gende. Caubeen +1",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Orison Earring",
        body="Orison Bliaud +2",hands="Bokwus Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tempered Cape",waist=gear.ElementalObi,legs="Orsn. Pantaloons +2",feet="Orvail Souliers"}

    sets.midcast.Curaga = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor Stone",
        head="Gende. Caubeen +1",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Orison Earring",
        body="Orison Bliaud +2",hands="Bokwus Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tempered Cape",waist=gear.ElementalObi,legs="Orsn. Pantaloons +2",feet="Orvail Souliers"}

    sets.midcast.CureMelee = {sub="Genbu's Shield",ammo="Incantor Stone",
        head="Gende. Caubeen +1",neck="Colossus's Torque",ear1="Lifestorm Earring",ear2="Orison Earring",
        body="Orison Bliaud +2",hands="Bokwus Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tempered Cape",waist=gear.ElementalObi,legs="Orsn. Pantaloons +2",feet="Orvail Souliers"}

    sets.midcast.Cursna = {main="Tamaxchi",sub="Genbu's Shield",ammo="Kalboron Stone",
        head="Orison Cap +2",neck="Colossus's Torque",
        body="Gendewitha Bliaut",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Mending Cape",legs="Mes'yohi Slacks",feet="Gende. Galoshes"}

    sets.midcast.StatusRemoval = {
        head="Orison Cap +2",legs="Orsn. Pantaln. +2"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Kirin's Pole",sub="Staff Strap",
        neck="Colossus's Torque",
        back="Mending Cape",waist="Bishop's Sash",feet="Orsn. Duckbills +2"}

    sets.midcast.Stoneskin = {
        neck="Orison Locket",
		back="Swith Cape",waist="Siegel Sash",feet="Gendewitha Galoshes"}

    sets.midcast.Auspice = {feet="Orison Duckbills +2"}

    sets.midcast.BarElement = {main="Tamaxchi",sub="Genbu's Shield",
        head="Orison Cap +2",neck="Colossus's Torque",
        body="Orison Bliaud +2",hands="Orison Mitts +2",
        back="Mending Cape",waist="Bishop's Sash",legs="Orsn. Pantaloons +2",feet="Orison Duckbills +2"}

    sets.midcast.Regen = {main="Bolelabunga",sub="Genbu's Shield",
        body="Cleric's Briault",hands="Orison Mitts +2",
        }

    sets.midcast.Protectra = {ring1="Sheltered Ring"}

    sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Piety Pantaloons"}


    sets.midcast['Divine Magic'] = {main="Bolelabunga",sub="Genbu's Shield",
        head="Orison Cap +2",neck="Colossus's Torque",ear1="Psystorm Earring",ear2="Enchntr. Earring +1",
        body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Sangoma", ring2="Weather. Ring",
        back="Refraction Cape",waist=gear.ElementalObi,legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

    sets.midcast['Dark Magic'] = {main="Bolelabunga", sub="Genbu's Shield",
        head="Nahtirah Hat",neck="Eddy Necklace",ear1="Gwati Earring",ear2="Enchntr. Earring +1",
        body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Sangoma", ring2="Weather. Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Mes'yohi Slacks",feet="Piety Duckbills +1"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Ngqoqwanb", sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Eddy Necklace",ear1="Gwati Earring",ear2="Enchntr. Earring +1",
        body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Sangoma", ring2="Weather. Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Mes'yohi Slacks",feet="Piety Duckbills"}

    sets.midcast.IntEnfeebles = {main="Ngqoqwanb", sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Eddy Necklace",ear1="Gwati Earring",ear2="Enchntr. Earring +1",
        body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Sangoma", ring2="Weather. Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Mes'yohi Slacks",feet="Piety Duckbills"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main=gear.Staff.HMP,sub="Oneiros Grip", head="Nares Cap",ear1="Moonshade Earring",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",
        waist="Austerity Belt",legs="Nares Trews"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Bolelabunga", sub="Genbu's Shield",ammo="Incantor Stone",
        head="Nefer Khat",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Enchntr. Earring +1",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}

    sets.idle.PDT = {main="Bolelabunga", sub="Genbu's Shield",ammo="Incantor Stone",
        head="Nefer Khat",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Enchntr. Earring +1",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Iximulew Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}

    sets.idle.Town = {main="Bolelabunga", sub="Genbu's Shield",ammo="Incantor Stone",
        head="Nefer Khat",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Enchntr. Earring +1",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}
    
    sets.idle.Weak = {main="Bolelabunga", sub="Genbu's Shield",ammo="Incantor Stone",
        head="Nefer Khat",neck="Twilight Torque",ear1="Moonshade Earring",ear2="Enchntr. Earring +1",
        body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Kumbira Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}
    
    -- Defense sets

    sets.defense.PDT = {main=gear.Staff.PDT,sub="Oneiros Grip",
        head="Gende. Caubeen +1",neck="Twilight Torque",
        body="Gendewitha Bliaut",hands="Gende. Gages +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Umbra Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    sets.defense.MDT = {main=gear.Staff.PDT,sub="Oneiros Grip",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Vanir Cotehardie",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Orison Mitts +2",back="Mending Cape"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
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
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
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
    -- Default macro set/book
    set_macro_page(4, 14)
end