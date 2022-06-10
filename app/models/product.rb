# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  code        :string(255)
#  description :string(255)
#  name        :string(255)
#  price       :decimal(10, 2)
#  stock       :integer
#  uuid        :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
    before_update :out_of_stock, if: :stock_changed?
    # callbacks
    before_save :notify_product_saving
    after_save  :notify_product_saved

    validates_with ProductValidator
    validate  :description_validate
    validates :name, presence: { message: 'El campo nombre no ha sido correctamente introducido' }
    validates :description, presence: { message: 'El campo descripción no ha sido correctamente introducido' }
    validates :price, numericality: { greater_than_or_equal_to: 1, message: 'El precio %{value} debe ser mayor o igual a 0' }
    validates :description, presence: true

    def notify_product_saving
      puts " - Producto #{self.name} guardado - "
    end

    def notify_product_saved
      puts " - Producto #{self.name} persistido y almacenado en bodega - "
    end

    def stock_changed?
        self.stock_was != self.stock && self.stock < 5
      end
    
      def out_of_stock
        puts " - Producto #{self.name} con stock reducido, llamar al proveedor - "
      end

    private

    def description_validate
        unless description.nil?
        errors.add(:description, 'La descripción debe tener más de 10 caracteres') unless description.length > 10
        end
    end
end
