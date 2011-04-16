module Acts
  module AsOrderable

    def self.included(base)
      base.extend AddActsAsMethod
    end

    module AddActsAsMethod

      # Should new element be first || last
      def acts_as_orderable(*sources)
        class_eval <<-END
          scope :ordered, order('element_order ASC')
          after_create :init_me!
          include Acts::AsOrderable::InstanceMethods
        END

        options = sources.extract_options!.stringify_keys
        new_pos = options.delete("position")
        new_pos = (new_pos && new_pos.to_sym == :first) ? :first : :last

        parent_column = options.delete("tree_column")
        # Determine tree column (first from param - else check default acts_as_tree "parent_id")
        unless parent_column
          parent_column = 'parent_id' if self.column_names.include? 'parent_id'
        end

        # Set class attributes
        cattr_accessor :new_element_position
        self.new_element_position = new_pos
        cattr_accessor :parent_column
        self.parent_column = parent_column

        # Define methods for assigning new parent - when we change parent
        # we need to be first or last element (according to new_el_pos)
        self.send(:define_method, "#{parent_column}=".to_sym) do |new_parent|
          super new_parent
          # If object exist (been saved and we're just changing its parent)
          init_me! unless self.new_record?
        end if parent_column
      end
    end

    # Istance methods
    module InstanceMethods

      # Fetches previous element - if there's no previous elements - return nil
      def previous
          self.class.where("element_order < #{self.element_order} #{search_node_query}").order("element_order DESC").limit(1).first
      end

      # Fetches previous element - if there's no previous elements - return nil
      def next
        self.class.where("element_order > #{self.element_order} #{search_node_query}").order("element_order ASC").limit(1).first
      end

      def move_up(steps = 1)
        move(steps)
      end

      def move_down(steps = 1)
        move(-steps)
      end

      private

      # Set default order
      def init_me!
        self.element_order = 0
        if self.class.new_element_position == :first
          self.class.where("id != #{self.id} #{search_node_query}").all.each do |el|
            el.element_order += 1
            el.save
          end
        else
          el = self.class.where("id != #{self.id} #{search_node_query}").order('element_order DESC').limit(1).first
          if el
            self.element_order = el.element_order+1
          else
            self.element_order = 0
          end
        end
        self.save
      end

      # Moves us up (+) or down (-)
      def move(steps)
        # If you want to stay in place - just stay
        return if steps == 0 || self.class.count < 2

        # Lets pick those records which are - we limit query - because we only
        # need those objects that are on our "way" to a new location
        way = steps < 0 ? ' > ' : ' < '
        way_order = steps < 0 ? 'ASC' : 'DESC'
        els = self.class.where("element_order #{way} ? #{search_node_query}
            AND id != ?", self.element_order, self.id).order("element_order #{way_order}").limit(steps.abs)

        return unless els.count > 0

        our_new_order = els.first.element_order
        els.each do |el|
          el.element_order += steps > 0 ? 1 : -1
          el.save
        end
        self.element_order = our_new_order
        self.save
      end

      # Builds query part used to fetch only elements from uor node (or do nothing)
      def search_node_query(init_end = true)
        p_c = self.class.parent_column
        # If parent exists - fetch our parent_id and put it into query
        if p_c
          parent_id_query = "#{p_c} "
          parent_id_query += self.send(p_c) ? "= #{self.send(p_c)}" : 'IS NULL'
          parent_id_query = "AND #{parent_id_query}" if init_end
        else
          parent_id_query = nil
        end
        parent_id_query
      end

    end
  end
end

ActiveRecord::Base.send(:include, Acts::AsOrderable)
