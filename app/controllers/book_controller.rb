class BookController < ApplicationController
  # used to define the layout which we gonna use 
  layout 'standard'
  #list down all the books
  def list
    @books = Book.all
  end
  #display detail of single book
  def show
    @book = Book.find(params[:id])
  end
  # create new object for book
  def new
   @book = Book.new
   #take all the subjects from DB to @subjects array
   @subjects = Subject.all
  end

  def create
    #create new book with user given inputs
     @book = Book.new(book_params)
   #book saves sucess, loads list of books available
     if @book.save
       redirect_to :action => 'list'
     else
       binding.pry
       @subjects = Subject.all
       render :action => 'new'
     end
  end
  #reqiured params to create new book details
  def book_params
   params.require(:books).permit(:title, :price, :subject_id, :description)
  end
  #used to update data books details which are changed by
  def update
    @book = Book.find(params[:id])

     if @book.update_attributes(book_param)
        redirect_to :action => 'show', :id => @book
     else
        @subjects = Subject.all
        render :action => 'edit'
     end
  end
  def book_param
   params.require(:book).permit(:title, :price, :subject_id, :description)
end
  #This function gives ability to edit the book details by user.
  def edit
    @book = Book.find(params[:id])
    @subjects = Subject.all
  end
  #this function gives ability to remove particular book from database
  def delete
    Book.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  #display particular subject
  def show_subjects
    @subject = Subject.find(params[:id])
  end
end
