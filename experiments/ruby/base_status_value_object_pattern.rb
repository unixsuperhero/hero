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

  @@mapping_two = {
    @@example_status_a => 'example_status_a',
    @@example_status_b => 'example_status_b',
  }.to_mash

  class << self
    def mapping # !> method redefined; discarding old mapping
      @@mapping
    end

    def mapping_two
      @@mapping_two
    end

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

    def name_map_two
      @@name_map_two ||= @@mapping_two
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
    attr_accessor :mapping, :mapping_two
  end

  IMPORTED  = 0
  WALKED    = 1
  WORKED    = 2
  COMPLETED = 3
  HIDDEN    = 4

  @imported  = IMPORTED
  @walked    = WALKED
  @worked    = WORKED
  @completed = COMPLETED
  @hidden    = HIDDEN

  @mapping = {
    IMPORTED  => 'imported',
    WALKED    => 'walked',
    WORKED    => 'worked',
    COMPLETED => 'completed',
    HIDDEN    => 'hidden',
  }.to_mash

  @mapping_two = {
    @imported  => 'imported',
    @walked    => 'walked',
    @worked    => 'worked',
    @completed => 'completed',
    @hidden    => 'hidden',
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

module StatusObject

  def self.extended(base)
    base.instance_eval <<-INST
      @mapping = {}
      class << self
        attr_reader :mapping
      end
    INST

    base.constants.each do |c|
      val = base.const_get(c)
      base.instance_eval <<-INST
        @#{c.downcase} = #{val}
        @mapping.merge!(@#{c.downcase} => '#{c.downcase}')

        class << self
          attr_reader :#{c.downcase}
        end
      INST
    end

    base.instance_eval <<-INST
      @ids = @mapping.keys
      @names = @mapping.values

      @id_map = @mapping.invert.to_mash
      @name_map = @mapping
      class << self
        attr_reader :ids, :names, :id_map, :name_map
      end
    INST

    base.class_eval <<-"CLASS"
      class << self
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

        def options_for_select
          id_map.map do |name,id|
            [new(id).display, id]
          end
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
    CLASS

    base.constants.each do |c|
      base.class_eval <<-"CLASS"
        def #{c.downcase}?
          id == #{c}
        end
      CLASS
    end
  end

end

class TestAutoGeneratingEverything
  IMPORTED  = 0
  WALKED    = 1
  WORKED    = 2
  COMPLETED = 3
  HIDDEN    = 4

  # @mapping = Mash.new
  # constants.each do |c|
  #   ap name: name, constant_name: c
  # end
  extend StatusObject
end


# CarStatus.ids # => nil
# CarStatus.names # => nil
# CarStatus.mapping # => nil

# [0,1,2,3,4].map do |id|
#   cs = CarStatus.by_id(id) # => #<CarStatus:0x007fd299933c08 @id=0, @name=nil>, #<CarStatus:0x007fd299931750 @id=1, @name=nil>, #<CarStatus:0x007fd29992a748 @id=2, @name=nil>, #<CarStatus:0x007fd2999039b8 @id=3, @name=nil>, #<CarStatus:0x007fd299902360 @id=4, @name=nil>
#   cs.id # => 0, 1, 2, 3, 4
#   cs.name # => nil, nil, nil, nil, nil
#   cs.display # => "", "", "", "", ""
#   {
#     imported?: cs.imported?,
#     walked?: cs.walked?,
#     worked?: cs.worked?,
#     completed?: cs.completed?,
#     hidden?: cs.hidden?
#   }
# end


CarStatusTwo.ids # => ["0", "1"]
CarStatusTwo.names # => ["example_status_a", "example_status_b"]
CarStatusTwo.mapping # => <Mash 0="imported" 1="walked" 2="worked" 3="completed" 4="hidden">
CarStatusTwo.mapping_two # => <Mash 0="imported" 1="walked" 2="worked" 3="completed" 4="hidden">
CarStatusTwo.name_map # => <Mash 0="example_status_a" 1="example_status_b">
CarStatusTwo.name_map_two # => <Mash 0="example_status_a" 1="example_status_b">
CarStatusTwo.imported # => 0
CarStatusTwo.walked # => 1
CarStatusTwo.worked # => 2
CarStatusTwo.completed # => 3
CarStatusTwo.hidden # => 4
CarStatusTwo.names # => ["example_status_a", "example_status_b"]
CarStatusTwo.mapping # => <Mash 0="imported" 1="walked" 2="worked" 3="completed" 4="hidden">
CarStatusTwo.mapping_two # => <Mash 0="imported" 1="walked" 2="worked" 3="completed" 4="hidden">

[0,1,2,3,4].map do |id|
  cs = CarStatusTwo.by_id(id) # => #<CarStatusTwo:0x007ff34397d950 @id=0, @name=nil>, #<CarStatusTwo:0x007ff343977ac8 @id=1, @name=nil>, #<CarStatusTwo:0x007ff343975548 @id=2, @name=nil>, #<CarStatusTwo:0x007ff34396d708 @id=3, @name=nil>, #<CarStatusTwo:0x007ff343967ce0 @id=4, @name=nil>
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
TestAutoGeneratingEverything.walked # => 1
TestAutoGeneratingEverything.ids # => [0, 1, 2, 3, 4]
TestAutoGeneratingEverything.names # => ["imported", "walked", "worked", "completed", "hidden"]
TestAutoGeneratingEverything.id_map # => <Mash completed=3 hidden=4 imported=0 walked=1 worked=2>
TestAutoGeneratingEverything.name_map # => {0=>"imported", 1=>"walked", 2=>"worked", 3=>"completed", 4=>"hidden"}
TestAutoGeneratingEverything.mapping # => {0=>"imported", 1=>"walked", 2=>"worked", 3=>"completed", 4=>"hidden"}

tage = TestAutoGeneratingEverything.by_id(2) # =>
tage.id # =>
tage.name # =>
tage.display # =>
tage.imported? # =>
tage.walked? # =>
tage.worked? # =>
tage.completed? # =>
tage.hidden? # =>





