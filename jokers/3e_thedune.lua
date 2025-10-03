SMODS.Joker{ --The Dune
    key = "thedune",
    config = {
        extra = {
            heartsindeck = 0
        }
    },
    loc_txt = {
        ['name'] = 'The Dune',
        ['text'] = {
            '{X:red,C:white}X0.15{} Mult for each',
            '{C:hearts}Heart{} cards in',
            'your {C:attention}full deck{}',
            '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local hearttally = 0
        if G.playing_cards then
            if next(SMODS.find_card("j_smeared")) then
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_suit("Hearts") and playing_card:is_suit("Diamonds") or SMODS.has_enhancement(playing_card, 'm_wild') then hearttally = hearttally + 1 end
                end
            else
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_suit("Hearts") or SMODS.has_enhancement(playing_card, 'm_wild') then hearttally = hearttally + 1 end
                end
            end
        end
        card.ability.extra.heartsindeck = hearttally * 0.15
        return {vars = {card.ability.extra.heartsindeck}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.heartsindeck
                }
        end
    end
}