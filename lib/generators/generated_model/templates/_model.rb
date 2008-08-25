class <%= class_name %> < ActiveRecord::Base
  
<% Association::ASSOCIATION_TYPES.each do |t| %>
<%   model.associations.find(:all, :conditions => ['association_type = ?', t]).each do |association| %>
  <%= t %> <%= ":#{association.foreign_model.name.underscore}" %>
<%   end %>
<% end %>
  
<% Validation::VALIDATION_TYPES.each do |t| %>
<% validations = model.validations.find(:all, :conditions => ['validation_type = ?', t]) %>
<%   unless validations.size == 0 %>
  <%= t %> <%= validations.collect {|v| ":#{v.column.name}"}.join(", ") %>
<%   end %>
<% end %>
end