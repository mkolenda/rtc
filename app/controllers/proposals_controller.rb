class ProposalsController < ApplicationController
  def create
    @author_id = logged_in_author.id
    @proposal = Proposal.create(proposal_params.merge(author_id: @author_id))

    begin
      Proposal.transaction do
        @draft = @proposal.create_draft!(params[:draft].empty? ? nil : draft_params, @author_id)
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

  def proposal_params
    params.require(:proposal).permit(:title, :body, :reviewed)
  end

  def draft_params
    params.require(:draft).permit(:version, :state)
  end

end
