#!/usr/bin/env ruby


#Autism Test

#It is a structure of squares on a page, with multiple openings in each square
#that allow passage from one square to the other.

# I will do my best to recreate the structure with ascii art:
#
#   +=======+(0)+========+========+(1)+=======+
#   |                    |                    |
#   |                    |                    |
#   +                    +                    +
#  (2)                  (3)                  (4)
#   +                    +                    +
#   |                    |                    |
#   |                    |                    |
#   |===+(5)+=====+(6)+=====+(7)+======+(8)+==+
#   |          |                   |          |
#   |          |                   |          |
#   +          +                   +          +
#  (9)        (10)                (11)       (12)
#   +          +                   +          +
#   |          |                   |          |
#   |          |                   |          |
#   +==+(13)+==+======+(14) +======+==+(15)+==+
#

# I am going to brute force it by counting each location (inside squares plus
# outside) as a location each.
#
# From each location there are possible doors, which change your location.
#

require 'awesome_print'

# door_destinations = [
#   {:outside=>:top_left, :top_left=>:outside},
#   {:outside=>:top_right, :top_right=>:outside},
#   {:outside=>:top_left, :top_left=>:outside},
#   {:top_left=>:top_right, :top_right=>:top_left},
#   {:outside=>:top_right, :top_right=>:outside},
#   {:top_left=>:bottom_left, :bottom_left=>:top_left},
#   {:top_left=>:bottom_middle, :bottom_middle=>:top_left},
#   {:top_right=>:bottom_middle, :bottom_middle=>:top_right},
#   {:top_right=>:bottom_right, :bottom_right=>:top_right},
#   {:outside=>:bottom_left, :bottom_left=>:outside},
#   {:bottom_left=>:bottom_middle, :bottom_middle=>:bottom_left},
#   {:bottom_middle=>:bottom_right, :bottom_right=>:bottom_middle},
#   {:outside=>:bottom_right, :bottom_right=>:outside},
#   {:outside=>:bottom_left, :bottom_left=>:outside},
#   {:outside=>:bottom_middle, :bottom_middle=>:outside},
#   {:outside=>:bottom_right, :bottom_right=>:outside}
# ]

class AutismTest
  class << self
    def doors_available
      [*0..15]
    end

    def positions
      {
        outside: [0,1,2,4,9,12,13,14,15],
        top_left: [0,2,3,5,6],
        top_right: [1,3,4,7,8],
        bottom_left: [5,9,10,13],
        bottom_middle: [6,7,10,11,14],
        bottom_right: [8,11,12,15]
      }
    end

    def door_destinations
      doors_available.map{|d|
        inclds = positions.keys.select{|k| positions[k].include?(d) }
        inclds << inclds[0]
        Hash[inclds.each_cons(2).map{|ec| ec }]
      }
    end

    def pick_door(pos, avail=[*0..15])
      `echo "#{avail.count}" >> autism.log` if avail.count > 10
      positions[pos]
      avs = avail.select{|avd| positions[pos].include?(avd) }
      `echo "#{avail.count} AVAIL COUNT == 0000000000 YAY!" >> autism.log` if avail.count == 0
      puts "AVAIL COUNT == 000 yay" if avail.count == 0
      return [pos, 'END (%s doors left)' % avail.count].join(' -> ') if avs.count == 0 || avail.count == 0
      found = false
      avs.map{|nd|
        break 'SKIPPED' if found == true
        np = door_destinations[nd][pos]
        [*pick_door(np, avail.select{|pa| pa != nd })].map{|map_result|
          this_result = [pos,nd] << map_result
          found = true if map_result[/\D0 doors/]
          this_result.join(' -> ')
        }
      }.flatten.select{|r| r[/\D0 doors/] }
    end

  end
end

ap AutismTest.pick_door(:outside), index: false

