class ProposalsController < ApplicationController
  def create
    @proposal = Proposal.create(params[:proposal])
    @proposal.author = logged_in_author

    # I'm making an assumption that the rest of this method is kosher in structure
    # so I can focus on the model logic
    begin
      Proposal.transaction do
        # current draft external links are also no longer current
        @proposal.expire_current_draft_external_links
        @proposal.build_draft(params[:draft], logged_in_author)
        @proposal.save!
      end
    rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid
      render :index and return false
    end

    redirect_to proposal_path(@proposal)
  end

  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  private
    # I stole these comments from https://guides.rubyonrails.org/v4.2/action_controller_overview.html#strong-parameters
    # ---
    # Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def proposal_params
      params.require(:proposal).permit(:title, :body, :reviewed)
    end

    def draft_params
      params.require(:draft).permit(:version, :state)
    end

end
