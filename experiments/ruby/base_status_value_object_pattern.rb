require 'pry'
require 'mash'
require 'awesome_print'

class BaseStatus
  EXAMPLE_STATUS_A = 0
  EXAMPLE_STATUS_B = 1

  class << self
    attr_reader :mapping, :ids, :names, :id_map, :name_map
    attr_reader :example_status_a, :example_status_b
  end

  @example_status_a = EXAMPLE_STATUS_A
  @example_status_b = EXAMPLE_STATUS_B

  @mapping = {
    EXAMPLE_STATUS_A => 'example_status_a',
    EXAMPLE_STATUS_B => 'example_status_b',
  }.to_mash

  @ids = @mapping.keys
  @names = @mapping.values

  @id_map = @mapping.invert.to_mash
  @name_map = @mapping

  class << self
    def by_id(id=ids.first)
      new(id)
    end

    def by_name(name=names.first)
      by_id(id_for name)
    end

    def id_for(name=names.first)
      id_map.fetch name, nil rescue nil
    end

    def name_for(id=ids.first)
      name_map.fetch id, nil rescue nil
    end
  end

  attr_accessor :id, :name
  def initialize(id=self.class.ids.first)
    @id = id
    @name = self.class.name_for(id)
  end

  def display
    name.titleize rescue ''
  end

  def example_status_a?
    id == EXAMPLE_STATUS_A
  end

  def example_status_b?
    id == EXAMPLE_STATUS_B
  end
end

class CarStatus < BaseStatus
  class << self
    attr_accessor :imported, :walked, :worked, :completed, :hidden
  end
  attr_reader :mapping, :ids, :names, :id_map, :name_map
  attr_reader :example_status_a, :example_status_b

  IMPORTED  = 0
  WALKED    = 1
  WORKED    = 2
  COMPLETED = 3
  HIDDEN    = 4

  @@imported  = IMPORTED
  @@walked    = WALKED
  @@worked    = WORKED
  @@completed = COMPLETED
  @@hidden    = HIDDEN

  @@mapping = {
    IMPORTED  => 'imported',
    WALKED    => 'walked',
    WORKED    => 'worked',
    COMPLETED => 'completed',
    HIDDEN    => 'hidden',
  }.to_mash

  def imported?
    id == IMPORTED
  end

  def walked?
    id == WALKED
  end

  def worked?
    id == WORKED
  end

  def completed?
    id == COMPLETED
  end

  def hidden?
    id == HIDDEN
  end
end






class BaseStatusTwo
  class << self
    attr_reader :mapping
  end

  # converted into methods because i don't think they would
  # work properly when this class is inherited:
  #
  # cattr_reader :ids, :names, :id_map, :name_map

  class << self
    attr_reader :example_status_a, :example_status_b
  end

  EXAMPLE_STATUS_A = 0
  EXAMPLE_STATUS_B = 1

  @@example_status_a = EXAMPLE_STATUS_A
  @@example_status_b = EXAMPLE_STATUS_B

  @@mapping = {
    EXAMPLE_STATUS_A => 'example_status_a',
    EXAMPLE_STATUS_B => 'example_status_b',
  }.to_mash

  class << self
    def ids
      @@ids ||= @@mapping.keys
    end

    def names
      @@names ||= @@mapping.values
    end

    def id_map
      @@id_map ||= @@mapping.invert.to_mash
    end

    def name_map
      @@name_map ||= @@mapping
    end

    def by_id(id=ids.first)
      new(id)
    end

    def by_name(name=names.first)
      by_id(id_for name)
    end

    def id_for(name=names.first)
      id_map.fetch name, nil rescue nil
    end

    def name_for(id=ids.first)
      name_map.fetch id, nil rescue nil
    end
  end

  attr_accessor :id, :name
  def initialize(id=self.class.ids.first)
    @id = id
    @name = self.class.name_for(id)
  end

  def display
    name.titleize rescue ''
  end

  def example_status_a?
    id == EXAMPLE_STATUS_A
  end

  def example_status_b?
    id == EXAMPLE_STATUS_B
  end
end

class CarStatusTwo < BaseStatusTwo
  class << self
    attr_accessor :imported, :walked, :worked, :completed, :hidden
  end

  IMPORTED  = 0
  WALKED    = 1
  WORKED    = 2
  COMPLETED = 3
  HIDDEN    = 4

  @@imported  = IMPORTED
  @@walked    = WALKED
  @@worked    = WORKED
  @@completed = COMPLETED
  @@hidden    = HIDDEN

  @@mapping = {
    IMPORTED  => 'imported',
    WALKED    => 'walked',
    WORKED    => 'worked',
    COMPLETED => 'completed',
    HIDDEN    => 'hidden',
  }.to_mash

  def imported?
    id == IMPORTED
  end

  def walked?
    id == WALKED
  end

  def worked?
    id == WORKED
  end

  def completed?
    id == COMPLETED
  end

  def hidden?
    id == HIDDEN
  end
end

# test auto generating everything after just setting the
# constants.
#
# this method of setting up might be best done by using a
# module as the BaseStatus and using the ::included
# or ::extended type callbacks
#
# if doing it that way, the include BaseStatus line probably
# needs to be at the bottom, after the constants are defined

class TestAutoGeneratingEverything
  IMPORTED  = 0
  WALKED    = 1
  WORKED    = 2
  COMPLETED = 3
  HIDDEN    = 4

  @mapping = Mash.new
  constants.each do |c|
    ap name: name, constant_name: c
  end
end


CarStatus.ids # => nil
binding.pry
CarStatus.names # => nil
CarStatus.mapping # => nil

[0,1,2,3,4].map do |id|
  cs = CarStatus.by_id(id) # => #<CarStatus:0x007fef498d79b8 @id=0, @name=nil>, #<CarStatus:0x007fef498d54d8 @id=1, @name=nil>, #<CarStatus:0x007fef498d39f8 @id=2, @name=nil>, #<CarStatus:0x007fef498d15b8 @id=3, @name=nil>, #<CarStatus:0x007fef498cb488 @id=4, @name=nil>
  cs.id # => 0, 1, 2, 3, 4
  cs.name # => nil, nil, nil, nil, nil
  cs.display # => "", "", "", "", ""
  {
    imported?: cs.imported?,
    walked?: cs.walked?,
    worked?: cs.worked?,
    completed?: cs.completed?,
    hidden?: cs.hidden?
  }
end

[0,1,2,3,4].map do |id|
  cs = CarStatusTwo.by_id(id) # => #<CarStatusTwo:0x007fef498c9020 @id=0, @name=nil>, #<CarStatusTwo:0x007fef498c61e0 @id=1, @name=nil>, #<CarStatusTwo:0x007fef498c3dc8 @id=2, @name=nil>, #<CarStatusTwo:0x007fef498c2360 @id=3, @name=nil>, #<CarStatusTwo:0x007fef498c0bc8 @id=4, @name=nil>
  cs.id # => 0, 1, 2, 3, 4
  cs.name # => nil, nil, nil, nil, nil
  cs.display # => "", "", "", "", ""
  {
    imported?: cs.imported?,
    walked?: cs.walked?,
    worked?: cs.worked?,
    completed?: cs.completed?,
    hidden?: cs.hidden?
  }
end

TestAutoGeneratingEverything::WALKED # => 1

# >> {
# >>              :name => "TestAutoGeneratingEverything",
# >>     :constant_name => :IMPORTED
# >> }
# >> {
# >>              :name => "TestAutoGeneratingEverything",
# >>     :constant_name => :WALKED
# >> }
# >> {
# >>              :name => "TestAutoGeneratingEverything",
# >>     :constant_name => :WORKED
# >> }
# >> {
# >>              :name => "TestAutoGeneratingEverything",
# >>     :constant_name => :COMPLETED
# >> }
# >> {
# >>              :name => "TestAutoGeneratingEverything",
# >>     :constant_name => :HIDDEN
# >> }
