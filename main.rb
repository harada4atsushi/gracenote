# coding:utf-8
require 'gracenote'
require 'sinatra'
require 'yaml'

get '/' do
  erb :index
end

post '/' do
  config = YAML.load_file( 'config.yml' )
  gracenote_conf = config["gracenote"]
  spec = {:clientID => gracenote_conf["clientID"], :clientTag => gracenote_conf["clientTag"],
    :userID => gracenote_conf["userID"]}
  gracenote = Gracenote.new(spec)
puts params[:artist]
puts params[:album_title]
puts params[:track_title]
  @result = gracenote.findTrack(params[:artist], params[:album_title], params[:track_title]).inspect
  erb :index
end

=begin
require 'active_record'
require 'mysql2'
require 'sinatra'
require './model/bill.rb'
require './model/customer.rb'

# DB設定ファイルの読み込み
ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection('development')

def p2attr(object, params)
  h = object.attributes
  object.attributes.each do |attr|
    unless ["created_at", "updated_at", "id"].include?(attr[0])
      h[attr[0]] = params[attr[0]]
    end
  end
  object.attributes = h
end

get '/' do
  @bills = Bill.all
  @customers = Customer.all
  erb :index
end

put "/:id" do
  @bill = Bill.find(params[:id])
  p2attr(@bill, params)
  @bill.save
  redirect "/"
end

post "/" do
  @bill = Bill.new
  p2attr(@bill, params)
  @bill.save()
  redirect "/"
end

delete "/:id" do
  @bill = Bill.find(params[:id])
  @bill.destroy
  redirect "/"
end

get "/customer" do
  @customers = Customer.all
  erb :customer
end

post "/customer" do
  @customer = Customer.new
  p2attr(@customer, params)
  @customer.save()
  redirect "/"
end

put "/customer/:id" do
  @customer = Customer.find(params[:id])
  p2attr(@customer, params)
  @customer.save
  redirect "/customer"
end
=end