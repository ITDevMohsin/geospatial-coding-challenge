class TicketsController < ApplicationController

  include ActionView::Layouts

  def index
    @tickets = Ticket.all
    render "tickets/index"
  end

  def show
    @ticket = Ticket.find(params[:id])
    render "tickets/show"
  end
end