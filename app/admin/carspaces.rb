ActiveAdmin.register Carspace do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :space_reference, :space_owner_id, :taken_user_id, :status
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form title: 'A custom title' do |f|
    inputs 'Details' do
      input :space_reference
      input :space_owner_id, label: "Space Owner ID"
      li "Created at #{f.object.created_at}" unless f.object.new_record?
      input :taken_user_id, label: "Space taken by ID"
      input :status
    end

    actions
  end


  controller do
    def create
      create! do |format|
        format.html { redirect_to admin_carspaces_path }
      end
    end
  end

end
