class RegisterController < ApplicationController
    def index
        @registers = Register.all        
    end
end