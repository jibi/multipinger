#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

module Dsl
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def dsl_attr(*ms)
      ms.each do |m|
        define_method m do |a|
          instance_variable_set "@#{m}", a
        end
      end
    end

    def dsl_cb(*ms)
      ms.each do |m|
        define_method m do |&block|
          instance_variable_set "@#{m}_cb", block
        end
      end
    end
  end
end
