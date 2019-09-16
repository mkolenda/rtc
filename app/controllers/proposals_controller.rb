class ProposalsController < ApplicationController
  def create
    @proposal = logged_in_author.proposals.build(proposal_params)
    @proposal.drafts.build if @proposal.drafts.empty?

    if @proposal.save
      redirect_to proposal_path(@proposal)
    else
      render :index and return false
    end
  end

  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  private

  def proposal_params
    params.require(:proposal).permit(:title, :body, drafts_attributes: [:state])
  end

end
