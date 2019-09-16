require 'rails_helper'

RSpec.describe ProposalsController, type: :controller do
  describe 'create' do
    let!(:author) { Author.create(:name => 'Abe Lincoln') }
    let(:proposal_params) do
      {
        title: 'Test Title',
        body: 'This is the body of the proposal',
        author_id: author.id
      }
    end
    let(:params) do
      {
        proposal: proposal_params
      }
    end

    describe 'the proposal' do
      it 'creates a proposal' do
        expect { post :create, params }.to change { Proposal.count }.from(0).to(1)
      end

      context 'when the proposal is valid' do
        it 'redirects to the show page' do
          post :create, params
          proposal = Proposal.last
          expect(response).to redirect_to(proposal_path(proposal))
        end
      end

      context 'when the proposal is invalid' do
        before do
          proposal_params.merge!({ body: '' })
        end
        it 'renders the index page' do
          post :create, params
          expect(response).to render_template(:index)
        end
      end
    end

    describe 'the draft' do
      it 'creates a draft' do
        expect { post :create, params }.to change { Draft.count }.from(0).to(1)
      end

      describe 'written_at' do
        before do
          travel_to Time.gm(2019)
        end

        after do
          travel_back
        end

        it 'sets written_at to now' do
          post :create, params
          draft = Draft.last
          expect(draft.written_at.to_s).to eq('2019-01-01 00:00:00 UTC')
        end
      end

      it "sets the draft's author to the proposal's author" do
        post :create, params
        draft = Draft.last
        expect(draft.author).to eq(author)
      end

      context 'when a state is passed in the params' do
        let(:params) do
          {
            proposal: proposal_params.merge({ drafts_attributes: [{ state: 'Test' }] })
          }
        end

        it 'sets the state to the state in the params' do
          post :create, params
          draft = Draft.last
          expect(draft.state).to eq('Test')
        end
      end

      context 'when no state is passed in the params' do
        it 'sets the state to New' do
          post :create, params
          draft = Draft.last
          expect(draft.state).to eq('New')
        end
      end

      it 'sets the version to 1' do
        post :create, params
        draft = Draft.last
        expect(draft.version).to eq(1)
      end

      it 'sets the draft as the current_draft for the proposal' do
        post :create, params
        proposal = Proposal.last
        draft = Draft.last
        expect(proposal.current_draft).to eq(draft)
      end
    end
  end
end
