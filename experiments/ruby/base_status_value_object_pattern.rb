require 'mash'
require 'awesome_print'

class BaseStatus
  class << self
    attr_reader :mapping, :ids, :names, :id_map, :name_map

    attr_reader :example_status_a, :example_status_b

    EXAMPLE_STATUS_A = 0
    EXAMPLE_STATUS_B = 1

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

    def by_id(id=ids.first)
      new(id)
    end

    def by_name(name=names.first)
      by_id(id_for name)
    end

    def id_for(name=names.first)
      id_map.fetch name
    end

    def name_for(id=ids.first)
      name_map.fetch id
    end
  end

  attr_accessor :id, :name
  def initialize(id=self.class.ids.first)
    @id = id
    @name = self.class.name_for(id)
  end

  def display
    name.titleize
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
      @@names ||= @@mappings.values
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
      id_map.fetch name
    end

    def name_for(id=ids.first)
      name_map.fetch id
    end
  end

  attr_accessor :id, :name
  def initialize(id=self.class.ids.first)
    @id = id
    @name = self.class.name_for(id)
  end

  def display
    name.titleize
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


[0,1,2,3,4].map do |id|
  cs = CarStatus.by_id(id) # =>
  cs.id # =>
  cs.name # =>
  cs.display # =>
  {
    imported?: cs.imported?,
    walked?: cs.walked?,
    worked?: cs.worked?,
    completed?: cs.completed?,
    hidden?: cs.hidden?
  }
end

[0,1,2,3,4].map do |id|
  cs = CarStatusTwo.by_id(id) # =>
  cs.id # =>
  cs.name # =>
  cs.display # =>
  {
    imported?: cs.imported?,
    walked?: cs.walked?,
    worked?: cs.worked?,
    completed?: cs.completed?,
    hidden?: cs.hidden?
  }
end

TestAutoGeneratingEverything.IMPORTED # =>

# ~> -:40:in `name_for': undefined method `fetch' for nil:NilClass (NoMethodError)
# ~> 	from -:47:in `initialize'
# ~> 	from -:28:in `new'
# ~> 	from -:28:in `by_id'
# ~> 	from -:263:in `block in <main>'
# ~> 	from -:262:in `map'
# ~> 	from -:262:in `<main>'
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
