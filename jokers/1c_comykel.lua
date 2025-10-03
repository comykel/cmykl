
SMODS.Joker{ --comykel
    key = "comykel",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = '{C:planet}c{}o{C:legendary}m{}{C:money}y{}{X:white,C:default}k{}el',
        ['text'] = {
            'Credits (for the entire mod):',
            '{X:dark_edition,C:white}comykel{}, {C:green}JokerForge{}, and ChatGPT{C:inactive}(lol){}',
            'this {C:attention}card{} was also used for {C:attention}code testing.{}',
            '{C:inactive}Unobtainable in normal runs.{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    no_collection = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },
    soul_pos = {
        x = 5,
        y = 1
    },
    in_pool = function(self, args)
          return (
          not args 
          or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rif' 
          or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
          )
          and true
      end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_4d071917', 1, 2, 'j_cmykl_comykel') then
                      local random_seal = SMODS.poll_seal({mod = 10, guaranteed = true})
                if random_seal then
                    context.other_card:set_seal(random_seal, true)
                end
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.BLUE})
                  end
            end
        end
    end
}