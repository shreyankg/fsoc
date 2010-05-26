#--
#   Copyright (C) 2010 Shreyank Gupta <sgupta@REDHAT.COM>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Affero General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Affero General Public License for more details.
#
#   You should have received a copy of the GNU Affero General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def highlighted
    return 'class="current_page_item"'
  end
  
  def devide_link(links)
    if !(links.nil? || links == '')
      out = []
      links.split(',').each do |link|
        out << link_to(link, link, :popup=> true)
      end
      out
    else
      '-'
    end
  end
  
  def dash(obj, replacement='-')
    if obj.nil? or obj == ""
      replacement
    elsif obj.respond_to?("each")
      sum = ""
      obj.each do |o|
        if o.nil? or o == ""
          return replacement
        else
          sum += o
        end
      end
      sum
    else
      obj
    end
  end
  
  def all_projects
    return Project.all.reverse
  end
  
  def verb(proposal)
    if proposal.status == 'accepted'
      'Allocate more tasks'
    else
      'Accept and allocate tasks'
    end
  end
end
