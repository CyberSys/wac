
include "wac/base.lua"

wac.toolSettings = function(t, variables)

	if !variables then error("No variables given.") end

	t.think = function(self, tool)
		if !self.varsUpdate or self.varsUpdate < CurTime() then
			for name, var in pairs(variables) do
				local temp = tool:GetClientInfo(name)
				temp = (tonumber(temp) or temp)
				if var != temp then
					variables[name] = temp
					tool.ClientConVar[name] = temp
					self:updateSetting(name, temp)
				end
			end
			self.varsUpdate = CurTime() + 0.2
		end
	end


	t.updateSetting = t.updateSetting or function(self, name, var)
		if !self.panel then return end
		if table.HasValue(self.trigger or {}, name) and CLIENT then
			self:buildPanel()
		end
	end


	t.BuildCPanel = function(panel)
		t.panel = panel
		t:buildPanel()
	end


	return t
end