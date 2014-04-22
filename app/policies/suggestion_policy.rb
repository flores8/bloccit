class SuggestionPolicy < ApplicationPolicy
	def index?
		user.present?
	end

	def show?
		index?
	end

	def new?
		index?
	end

	def update?
		user.present? && (record.user == user || user.role?(:admin))
	end

	def edit?
		update?
	end

	def destroy?
		update?
	end
end