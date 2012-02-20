module ApplicationHelper

  def link_to_remove_fields(name, builder)
    builder.hidden_field(:_destroy) + link_to_function( name, "remove_fields(this)")
  end


  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_msisdn") do |builder|
        render("shared/profile_newform", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => "btn")
  end
end
