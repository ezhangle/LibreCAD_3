--Remove "Current operation" group in the toolbar
local function remove_operation_group()
    if(hideUI ~= true) then
        local group = quickAccessTab:groupByName("Current operation")
        if(group ~= nil) then
            quickAccessTab:removeGroup(group)
        end
    end

    active_widget():viewer():setOperationActive(false)
end

--End the current operation, even if it's not finished
function finish_operation()
    local op = luaInterface:operation(active_widget().id);
    if(op ~= nil) then
        op:close()
    end
end

--Add a cancel button in the toolbar for the current operation
local function create_cancel_button()
    if(hideUI ~= true) then
        local operationGroup = quickAccessTab:addGroup("Current operation")

        local cancelButton = create_button("", ":/icons/quit.svg")
        quickAccessTab:addWidget(operationGroup, cancelButton, 0, 0, 1, 1)
        luaInterface:luaConnect(cancelButton, "pressed()", finish_operation)
    end
end

--End current operation and create new cancel button
function new_operation()
    finish_operation()
    create_cancel_button()

    active_widget():viewer():setOperationActive(true)
end

luaInterface:registerEvent('operationFinished', remove_operation_group)

--Every function corresponding to the buttons in the toolbar or commands in cli widget
function create_line()
    finish_operation()
    luaInterface:setOperation(active_widget().id, LineOperations(active_widget().id))
end

function create_circle()
    finish_operation()
    luaInterface:setOperation(active_widget().id, CircleOperations(active_widget().id))
end

function create_arc()
    finish_operation()
    luaInterface:setOperation(active_widget().id, ArcOperations(active_widget().id))
end

function create_ellipse()
    finish_operation()
    luaInterface:setOperation(active_widget().id, EllipseOperations(active_widget().id, false))
end

function create_arc_ellipse()
    finish_operation()
    luaInterface:setOperation(active_widget().id, EllipseOperations(active_widget().id, true))
end

function create_dim_aligned()
    finish_operation()
    luaInterface:setOperation(active_widget().id, DimAlignedOperations(active_widget().id))
end

function create_dim_angular()
    finish_operation()
    luaInterface:setOperation(active_widget().id, DimAngularOperations(active_widget().id))
end

function create_dim_diametric()
    finish_operation()
    luaInterface:setOperation(active_widget().id, DimDiametricOperations(active_widget().id))
end

function create_dim_linear()
    finish_operation()
    luaInterface:setOperation(active_widget().id, DimLinearOperations(active_widget().id))
end

function create_dim_radial()
    finish_operation()
    luaInterface:setOperation(active_widget().id, DimRadialOperations(active_widget().id))
end

function create_spline()
    finish_operation()
    create_cancel_button()
    luaInterface:setOperation(active_widget().id, SplineOperations(active_widget().id))
end

function create_lw_polyline()
    finish_operation()
    create_cancel_button()

    if(hideUI ~= true) then
        local group = quickAccessTab:groupByName("Current operation")

        local lineButton = create_button("", ":/icons/linesnormal.png")
        quickAccessTab:addWidget(group, lineButton, 0, 1, 1, 1)
        luaInterface:luaConnect(lineButton, "pressed()", function()
            luaInterface:operation(active_widget().id):createLine()
        end)

        local arcButton = create_button("", ":/icons/arc.svg")
        quickAccessTab:addWidget(group, arcButton, 1, 1, 1, 1)
        luaInterface:luaConnect(arcButton, "pressed()", function()
            luaInterface:operation(active_widget().id):createArc()
        end)
    end

    luaInterface:setOperation(active_widget().id, LWPolylineOperations(active_widget().id))
end

function move_selected_entities()
    new_operation()
    luaInterface:setOperation(active_widget().id, MoveOperation(active_widget().id))
end

function rotate_selected_entities()
    new_operation()
    luaInterface:setOperation(active_widget().id, RotateOperation(active_widget().id))
end

function copy_selected_entities()
    new_operation()
    luaInterface:setOperation(active_widget().id, CopyOperation(active_widget().id))
end

function scale_selected_entities()
    new_operation()
    luaInterface:setOperation(active_widget().id, ScaleOperation(active_widget().id))
end

function remove_selected_entities()
    new_operation()
    luaInterface:setOperation(active_widget().id, RemoveOperation(active_widget().id))
end

function trim_entity()
    new_operation()
    luaInterface:setOperation(active_widget().id, TrimOperation(active_widget().id))
end