module AccountsHelper
	def package_badge_helper
		if @account.has_platinum_package
			badge = '<span class="label">Platinum Package</span>'
		elsif @account.has_gold_package
			badge = '<span class="label label-warning">Gold Package</span>'
		elseif @account.has_free_package
			badge = '<span class="label label-info">Free Package</span>'
		end
		return raw badge
	end
end
