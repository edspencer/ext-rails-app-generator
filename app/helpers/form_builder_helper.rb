module FormBuilderHelper
  def submit_row(name)
    @template.content_tag('div', submit_tag(name), {:class => 'submitRow'})
  end
end

class GenericFormBuilder < ActionView::Helpers::FormBuilder
  (field_helpers  + %w(select) - %w(apply_form_for_options! radio_button)).each do |selector|
    src = <<-END_SRC
      def #{selector}(field, options={})
        label = (options.delete(:label) || field.to_s.humanize)
        @template.content_tag("div",
          @template.content_tag('label', label + ':', {:for => @object_name.to_s + "_" + field.to_s}) + super + "\n", 
          {:class => 'formRow'})
      end
      
      def #{selector}s(*names)
        names.flatten.collect {|f| #{selector}(f)}
      end
    END_SRC
    class_eval src, __FILE__, __LINE__
  end
    
  def password_with_confirmation
    password_field(:password) + password_field(:password_confirmation)
  end
end