class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/' do
    redirect to '/recipes'
    # When visiting the base page, you will be directed to /recipes 
    # which is the get request below
    # I tried erb :recipes, but it didn't work
  end

  get '/recipes' do
    @recipes = Recipe.all
    # This will populate all recipes
    erb :index
    # This will pull out the recipes in the index page
  end

  get '/recipes/new' do
    erb :new # This is where you create a recipe to display in /recipes above
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    
    redirect to "/recipes/#{@recipe.id}"
    # post/patch/delete use redirect(although I think erb does the same job)
    # posting recipes and redirecting to specific recipe id
  end

  get '/recipes/:id' do
    # This is grabbing the id number specific to that recipes page
    @recipe = Recipe.find(params[:id])
    # Created an instance variable recipe to find that specific Recipe ID

    erb :show
    # This will direct the user to recipes/show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    # Just like the above :id get request, we're finding the specific
    # id of the recipe, but this time, to edit.
    erb :edit
    # Well... when there's an edit, there's a patch
    # When you edit something it becomes a patch(I think this sounds better)
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete

    redirect to '/recipes'
  end
end
