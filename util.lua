cmykl_util = {}

cmykl_util.config = SMODS.current_mod.config

assert(SMODS.load_file("ui.lua"))()

cmykl_util.enabled_quips = {
  'comy_quips',
}

function cmykl_util.load_items(names, path)
  for i = 1, #names do
    assert(SMODS.load_file(path .. '/' .. names[i] .. '.lua'))()
  end
end