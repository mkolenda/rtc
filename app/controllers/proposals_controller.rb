class ProposalsController < ApplicationController
  def create
    params.require(:proposal).permit!
    params.require(:draft).permit!
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

end