class VendorsController < ApplicationController
  include Pagy::Backend
  before_action :set_vendor, only: [:show, :edit, :update, :destroy, :claim]
  before_action :set_school, only: [:index]

  def index
    @vendors = Vendor.all
    @school = School.find_by(id: params[:school_id]) if params[:school_id]
    @vendors = @school.try(:vendors) || Vendor
    @vendors = @vendors.search(params[:keywords]) if params[:keywords].present?
    @vendors = @vendors.geosearch(params[:location]) if params[:location].present?
    @pagy, @vendors = pagy(@vendors, items: 5)
  end

  def show
  end

  def edit
  end

  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to @vendor, notice: 'Vendor was successfully created.'
    else
      render :new
    end
  end

  def update
    if @vendor.update(vendor_params)
      redirect_to @vendor, notice: 'Vendor was successfully updated.'
    else
      render :edit 
    end
  end

  def destroy
    @vendor.destroy
    redirect_to vendors_url, notice: 'Vendor was successfully destroyed.'
  end

  def claim
    if @vendor.update(user: current_user)
      redirect_to @vendor, notice: "Vendor successfully claimed."
    else
      render :show
    end
  end

  private
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    def set_school
      @school = School.find(params[:school_id]) if params[:school_id]
    end

    def vendor_params
      params.require(:vendor).permit(:name, :address, :phone, :email, :website, :description, :content)
    end
end
