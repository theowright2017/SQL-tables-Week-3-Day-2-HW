require ('pry-byebug')
require_relative('models/bounty.rb')

bounty1 = Bounty.new( { 'name' => 'John',
                        'species' => 'Shapeshifter',
                        'bounty_value' => '250',
                        'danger_level' => 'medium'
  })

bounty1.save()

# Bounty.delete_all()

bounty1.name = "Jimmy"
bounty1.update()
# binding.pry



bounty2 = Bounty.new ( { 'name' => 'Tony',
                          'species' => 'Facelicker',
                          'bounty_value' => '1000',
                          'danger_level' => 'extreme'
  })

  bounty2.save()
