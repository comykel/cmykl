SMODS.Joker{ --Company ID
    key = "companyid",
    config = {
        extra = {
            expenses = 0
        }
    },
    loc_txt = {
        ['name'] = '{C:planet}C{}ompany ID',
        ['text'] = {
            [1] = 'Gains {C:blue}+1{} Chips',
            [2] = 'for every {C:money}$1{} spent',
            [3] = '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.expenses}}
    end,

    calculate = function(self, card, context)
        if context.money_altered and type(context.amount) == "number" then
            local spendy = context.amount
            if spendy < 0 then
                card.ability.extra.expenses = card.ability.extra.expenses + (-spendy)
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            
                return {
                    chips = card.ability.extra.expenses
                }
        end
    end
}