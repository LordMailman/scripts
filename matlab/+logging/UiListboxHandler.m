classdef UiListboxHandler < logging.Handler
    %UILISTBOXHANDLER Logs to a uilistbox element and inherits from logging.Handler.
    %
    %   Handlers are not meant to be used on their own, use Logger.addHandler
    %   to add a Handler to a Logger.
    %
    %Usage
    %   Add a UiListboxHandler ('Listbox1') to a Logger that will write to a listbox.
    %       logger = logging.getLogger;
    %       listbox = uicontrol('Style', 'listbox');
    %       logger.addHandler('listbox', 'Target', listbox, 'Name', 'Listbox1');
    %
    %   Add a UiListboxHandler ('Listbox1') that only handles messages of Warning-level and above
    %       logger = logging.getLogger;
    %       logger.addHandler('lsitbox', 'Target', listbox, 'Name', 'Listbox1', 'Level', 'warning');
    %
    %   Add a UiListboxHandler that uses a custom datetime format
    %       logger = logging.getLogger;
    %       logger.addHandler('listbox', 'Target', listbox, 'Format', 'HH:MM:SS');
    %
    %See also: logging, logging.UiListboxHandler.UiListboxHandler,
    %   logging.Handler, logging.Logger.addHandler

    % Alex St. Amour

    properties (Access = public)
        Name = mfilename('class') % The Name of the Handler, used to determine whether a Handler is unique. (Default: "UiListboxHandler")
        LogLevel = logging.LogLevel.Info % The level of the Handler. Messages below this level will be ignored by this Handler. (Default: "Info")
        DateFormat = "HH:MM:SS" % Controls the format of how the log's datetime is displayed. See also: datetime.Format. (Default: "HH:MM:SS")
        Target(1,1) % The Listbox uicontrol that messages are sent to.
    end % Public properties

    methods (Access = public)
        function obj = UiListboxHandler(varargin)
            %UILISTBOXHANDLER Returns a logging.UiListboxHandler object.
            %
            %Required Parameter Arguments
            %   Target (uicontrol): The Listbox uicontrol that messages are sent to.
            %
            %Optional Parameter Arguments
            %   Name (string-like): % The Name of the Handler, used to determine whether a Handler is unique. (Default: "UiListboxHandler")
            %   LogLevel (string-like): The level of the Handler. Messages below this level will be ignored by this Handler. (Default: "Info")
            %   DateFormat (string-like): Controls the format of how the log's datetime is displayed. See also: datetime.Format (Default: "HH:MM:SS")
            %
            %See also: logging.UiListboxHandler,
            %   logging.Logger.addHandler, datetime.Format

            parser = inputParser;
            parser.addParameter('Name', obj.Name, @validators.mustBeStringLike);
            parser.addParameter('LogLevel', string(obj.LogLevel), @validators.mustBeStringLike);
            parser.addParameter('DateFormat', obj.DateFormat, @validators.mustBeStringLike);
            parser.addParameter('Target', double.empty); % This default value fails the validator on purpose
            parser.parse(varargin{:});
            obj.Name = string(parser.Results.Name);
            obj.LogLevel = logging.LogLevel(parser.Results.LogLevel);
            obj.DateFormat = string(parser.Results.DateFormat);
            targetListbox = parser.Results.Target;
            if isempty(targetListbox) || ~isvalid(targetListbox)
                error('logging:UiListboxHandler:InvalidTarget', ...
                      'The target listbox is invalid.');
            end
            validators.mustBeUiListbox(targetListbox);
            obj.Target = targetListbox;
        end % Constructor

        function tfResult = isValid(obj)
            %ISVALID Returns true if the object and the Target are valid.
            %
            %See also: logging.UiListboxHandler, isvalid

            tfResult = isvalid(obj) & isvalid(obj.Target);
        end % isValid

        function processMessage(obj, msg)
            %PROCESSMESSAGE Called by Logger.log to write the message to the listbox.
            %
            %Required Arguments
            %   msg (struct)                            - The message struct
            %       .Level (logging.LogLevel)  - The level of the message
            %       .Timestamp (double)                 - Time in Epoch seconds when the message was logged
            %       .Message (string)                   - The message content
            %       .Error (MException)                 - An attached error, if any
            %
            %See also: logging.UiListboxHandler

            % If the listbox has been deleted, delete this handler.
            if ~isvalid(obj.Target)
                delete(obj);
                return
            end

            % Start with the current content of the listbox
            if isempty(obj.Target.Items)
                stringList = string.empty;
            else
                stringList = string(obj.Target.Items);
            end

            % Loop over every message in order, then add those lines to the listbox
            %TODO(ALEX): Initialize the stringList to the number of messages that aren't filtered
            for indMsg = 1:numel(msg)
                msgLevel = msg(indMsg).Level;
                if msgLevel >= obj.LogLevel
                    stringList(end+1) = sprintf( ...
                        '%s %s: %s', ...
                        datestr(msg(indMsg).Timestamp, obj.DateFormat), ...
                        upper(string(msgLevel)), ...
                        msg(indMsg).Message ...
                    );
                end
            end
            obj.Target.Items = cellstr(stringList);

            % Move the listbox selector Value to the most recent message
            if ~isempty(stringList)
                obj.Target.Value = stringList(end);
                scroll(obj.Target, 'bottom');
            end
        end % processMessage
    end % Public methods
end % classdef
