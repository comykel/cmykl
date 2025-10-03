SMODS.Joker{ --Twister
    key = "twister",
    loc_txt = {
        ['name'] = 'Twister',
        ['text'] = {
            'Triggering {C:attention}seals{} has a',
            '{C:green}#1# in #2#{} chance of',
            'additionally triggering',
            'other {C:attention}seals\'{} effects'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    config = { extra = { max = 4, min = 0, repetitions = 1, money = 3, odds = 4} },
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl_twister') 
        return {vars = {new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
    if G.__twister_active then return end
    G.__twister_active = true

    local sealer = nil
    local randoseal = false

    if context.cardarea == G.hand and context.end_of_round then
        if context.other_card.seal == "Blue" then
            if SMODS.pseudorandom_probability(card, 'group_0_4d071917', 1, card.ability.extra.odds, 'j_cmykl_twister') then
                sealer = pseudorandom('Cmykl_twister', card.ability.extra.min, card.ability.extra.max)
                randoseal = true
            end
        end
    end
    if context.cardarea == G.hand and context.end_of_round then
        if context.other_card.seal == "Red" and ((SMODS.has_enhancement(context.other_card, 'm_steel')) or SMODS.has_enhancement(context.other_card, 'm_gold')) then
            if SMODS.pseudorandom_probability(card, 'group_0_4d071917', 1, 8, 'j_cmykl_twister') then
                sealer = pseudorandom('Cmykl_twister', card.ability.extra.min, card.ability.extra.max)
                randoseal = true
            end
        end
    end
    if context.individual and context.cardarea == G.play then
        if context.other_card.seal == "Gold" or (context.other_card.seal == "Red" and SMODS.pseudorandom_probability(card, 'group_0_4d071917', 1, 2, 'j_cmykl_twister')) then
            if SMODS.pseudorandom_probability(card, 'group_0_4d071917', 1, card.ability.extra.odds, 'j_cmykl_twister') then
                sealer = pseudorandom('Cmykl_twister', card.ability.extra.min, card.ability.extra.max)
                randoseal = true
            end
        end
    end
    if context.discard then
        if context.other_card.seal == "Purple" then
            if SMODS.pseudorandom_probability(card, 'group_0_4d071917', 1, card.ability.extra.odds, 'j_cmykl_twister') then
                sealer = pseudorandom('Cmykl_twister', card.ability.extra.min, card.ability.extra.max)
                randoseal = true
            end
        end
    end
    if context.remove_playing_cards then
        for k, removed_card in ipairs(context.removed) do
            if removed_card.seal == "cmykl_spectralseal" then
                if SMODS.pseudorandom_probability(card, 'group_0_4d071917', 1, card.ability.extra.odds, 'j_cmykl_twister') then
                    sealer = pseudorandom('Cmykl_twister', card.ability.extra.min, card.ability.extra.max)
                    randoseal = true
                end
            end
        end
    end

    local result = nil
    if sealer == 0 then
                result = { repetitions = card.ability.extra.repetitions, message = '?!' }
    elseif sealer == 1 then
        result = {
            func = function()
                local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Tarot'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                if created_consumable then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                        message = localize('k_plus_tarot'),
                        colour = G.C.PURPLE
                    })
                end
                return true
            end
        }
    elseif sealer == 2 then
        result = {
            func = function()
                local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                if created_consumable then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                        message = localize('k_plus_planet'),
                        colour = G.C.SECONDARY_SET.Planet
                    })
                end
                return true
            end
        }
    elseif sealer == 3 then
        result = {
            dollars = card.ability.extra.money
        }
    elseif sealer == 4 then
        if SMODS.pseudorandom_probability(card, 'group_0_4d071917', 1, 4, 'j_cmykl_twister') then
            result = {
            func = function()
                local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Spectral'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                if created_consumable then
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral
                    })
                end
                return true
            end
        }
        end
    end

    G.__twister_active = false
    return result
end
}