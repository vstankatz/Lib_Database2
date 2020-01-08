require('sinatra')
require('sinatra/reloader')
require('./lib/triangle')
require('pry')
also_reload('lib/**/*.rb')

get ('/') do
  erb(:triangle_input)


end

post ('/') do
  a = params[:side1].to_i
  b = params[:side2].to_i
  c = params[:side3].to_i
  @triangle = Triangle.new(a, b, c)
  outcome = @triangle.is_a_triangle?

  if outcome == true
    erb(:triangle_output)
  else
    erb(:triangle_fail)
  end
end
