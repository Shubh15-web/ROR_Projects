ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    
    # Calculate revenue dynamically
    total_revenue = 0
    today_revenue = 0
    monthly_revenue = 0
    
    Booking.all.each do |booking|
      if booking.end_time && booking.start_time
        duration = ((booking.end_time - booking.start_time) / 1.hour).ceil
        cost = duration * 20
        total_revenue += cost
        
        if booking.created_at >= Date.current.beginning_of_day
          today_revenue += cost
        end
        
        if booking.created_at >= Date.current.beginning_of_month
          monthly_revenue += cost
        end
      elsif booking.start_time && booking.status == 'active'
        duration = ((Time.current - booking.start_time) / 1.hour).ceil
        cost = duration * 20
        total_revenue += cost
        
        if booking.created_at >= Date.current.beginning_of_day
          today_revenue += cost
        end
        
        if booking.created_at >= Date.current.beginning_of_month
          monthly_revenue += cost
        end
      end
    end
    
    # Statistics
    total_slots = ParkingSlot.count
    available_slots = ParkingSlot.where(status: 'free').count
    occupied_slots = ParkingSlot.where(status: 'occupied').count
    total_bookings = Booking.count
    active_bookings = Booking.where(status: 'active').count
    
    div class: "blank_slate_container", id: "dashboard_default_message" do
      div class: "blank_slate" do
        div class: "blank_slate_content" do
          h1 "Parking Management Dashboard", style: "color: #333; margin-bottom: 30px;"
          
          # Revenue Section
          div style: "margin-bottom: 40px;" do
            h2 "💰 Revenue Analytics", style: "color: #28a745; margin-bottom: 20px;"
            div style: "display: flex; gap: 20px; margin-bottom: 30px; flex-wrap: wrap;" do
              div style: "background: linear-gradient(135deg, #28a745, #20c997); color: white; padding: 25px; border-radius: 15px; text-align: center; flex: 1; min-width: 200px; box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);" do
                h1 "₹#{total_revenue}", style: "margin: 0; font-size: 2.5rem; font-weight: bold;"
                p "Total Revenue", style: "margin: 10px 0 0 0; font-size: 1.1rem; opacity: 0.9;"
                small "All time earnings", style: "opacity: 0.8;"
              end
              
              div style: "background: linear-gradient(135deg, #ffc107, #fd7e14); color: white; padding: 25px; border-radius: 15px; text-align: center; flex: 1; min-width: 200px; box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);" do
                h1 "₹#{today_revenue}", style: "margin: 0; font-size: 2.5rem; font-weight: bold;"
                p "Today's Revenue", style: "margin: 10px 0 0 0; font-size: 1.1rem; opacity: 0.9;"
                small "#{Date.current.strftime('%d %B %Y')}", style: "opacity: 0.8;"
              end
              
              div style: "background: linear-gradient(135deg, #17a2b8, #6f42c1); color: white; padding: 25px; border-radius: 15px; text-align: center; flex: 1; min-width: 200px; box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);" do
                h1 "₹#{monthly_revenue}", style: "margin: 0; font-size: 2.5rem; font-weight: bold;"
                p "This Month", style: "margin: 10px 0 0 0; font-size: 1.1rem; opacity: 0.9;"
                small "#{Date.current.strftime('%B %Y')}", style: "opacity: 0.8;"
              end
            end
          end
          
          # Parking Statistics
          div style: "margin-bottom: 40px;" do
            h2 "🅿️ Parking Statistics", style: "color: #007bff; margin-bottom: 20px;"
            div style: "display: flex; gap: 15px; margin-bottom: 30px; flex-wrap: wrap;" do
              div style: "background: #f8f9fa; border: 2px solid #007bff; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 150px;" do
                h2 "#{total_slots}", style: "color: #007bff; margin: 0; font-size: 2rem;"
                p "Total Slots", style: "margin: 5px 0 0 0; color: #666;"
              end
              
              div style: "background: #f8f9fa; border: 2px solid #28a745; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 150px;" do
                h2 "#{available_slots}", style: "color: #28a745; margin: 0; font-size: 2rem;"
                p "Available", style: "margin: 5px 0 0 0; color: #666;"
              end
              
              div style: "background: #f8f9fa; border: 2px solid #dc3545; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 150px;" do
                h2 "#{occupied_slots}", style: "color: #dc3545; margin: 0; font-size: 2rem;"
                p "Occupied", style: "margin: 5px 0 0 0; color: #666;"
              end
              
              div style: "background: #f8f9fa; border: 2px solid #6c757d; padding: 20px; border-radius: 10px; text-align: center; flex: 1; min-width: 150px;" do
                occupancy = total_slots > 0 ? ((occupied_slots * 100) / total_slots).round : 0
                h2 "#{occupancy}%", style: "color: #6c757d; margin: 0; font-size: 2rem;"
                p "Occupancy", style: "margin: 5px 0 0 0; color: #666;"
              end
            end
          end
          
          # Pricing Info
          div style: "background: #e9ecef; padding: 20px; border-radius: 10px; text-align: center;" do
            h3 "💵 Pricing: ₹20 per hour", style: "color: #495057; margin: 0;"
            p "Revenue calculated based on booking duration × hourly rate", style: "margin: 10px 0 0 0; color: #6c757d;"
          end
        end
      end
    end
  end
end