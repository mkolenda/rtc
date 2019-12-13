class ProposalsController < ApplicationController
  def create
    @author_id = params[:proposal][:author_id]
    @proposal = Proposal.create(params[:proposal])
    @proposal.author_id = @author_id

    begin
      Proposal.transaction do
        @draft = @proposal.create_draft!(params[:draft], @author_id)
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
