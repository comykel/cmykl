SMODS.Joker{ -- Apparition
    key = "apparition",
    config = {
        extra = {
            odds = 8
        }
    },
    loc_txt = {
        ['name'] = 'Apparition',
        ['text'] = {
            [1] = '{C:green}#1# in #2# chance{} to',
            [2] = 'create a {C:spectral}Spectral{} card',
            [3] = 'per {C:attention}reroll{} in the shop'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },
    soul_pos = {
        x = 1,
        y = 2
    },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
        end
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl__019apparition') 
        return {vars = {new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.reroll_shop  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_ac0a1114', 1, card.ability.extra.odds, 'j_cmykl__019apparition', false) then
              SMODS.calculate_effect({
    func = function()
    for i = 1, 1 do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
            play_sound('timpani')
            SMODS.add_card({ set = 'Spectral', soulable = true, })                            
            card:juice_up(0.3, 0.5)
            return true
        end
        }))
    end
    delay(0.6)

                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                  end}, card)
          end
            end
        end
    end
}