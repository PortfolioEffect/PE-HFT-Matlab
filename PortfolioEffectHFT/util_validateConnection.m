function [result] = util_validateConnection()
global clientConnection
result=true;
if ~exist(fullfile(prefdir,'matICE9Remote.mat'), 'file')
    msgbox('Function util_setCredentials() should be called before.To retrieve your account credentials, please log in to your account or register for a free account at https://www.portfolioeffect.com/registration.');
    error('Function util_setCredentials() should be called before.To retrieve your account credentials, please log in to your account or register for a free account at https://www.portfolioeffect.com/registration.')
end
if isempty(clientConnection)
    try
        clientConnection=com.portfolioeffect.quant.client.ClientConnection;
        temp=load(fullfile(prefdir,'matICE9Remote.mat'));
        clientConnection.setUsername(temp.login(1));
        clientConnection.setPassword(temp.login(2));
        clientConnection.setApiKey(temp.login(3));
        clientConnection.setHost(temp.login(4));
    catch ME
        exception = ME.identifier;
        isError=strfind(exception,'MATLAB:undefinedVarOrClass');
        if ~isempty(isError)
                            fprintf(cat(2,'\n',...
                    '+++++++++++++++++++++++++++++++++++++++++++++++++','\n',...
                    'Welcome to PortfolioEffect Quant Toolbox.','\n'));
            complete = true;
            jpath = javaclasspath('-all');
            isice9jar=strfind(jpath,fullfile(prefdir,'portfolioeffect-quant-client-1.0-allinone.jar'));
            enable=false;
            for i = 1:length(jpath)
                if ~isempty(isice9jar{i})
                    enable=true;
                end
            end
            if ~exist(fullfile(prefdir,'quant-client-1.0-allinone.jar'), 'file')
                ex=false;
                fprintf(cat(2,'\n',...
                    'Setup will download required binary files (~5mb).','\n',...
                    'Please, wait...', '\n'));
                [f,status]=urlwrite('http://portfolioeffect.com/downloads/platform/quant/stable/portfolioeffect-quant-client-1.0-allinone.jar',fullfile(prefdir,'portfolioeffect-quant-client-1.0-allinone.jar'));
                if(status ~= 1)
                    fprintf(cat(2,...
                        'ERROR: File download failed.', '\n',...
                        'Check your firewall and internet connection.','\n',...
                        '+++++++++++++++++++++++++++++++++++++++++++++++++','\n'));
                    complete = false;
                else
                    fprintf(cat(2,...
                        'SUCCESS. File downloaded to: ','\n',...
                        fullfile(prefdir,'portfolioeffect-quant-client-1.0-allinone.jar'), '\n',...,
                        'Updating java class path file...','\n'));
                end
            end
            if ~enable
                if (exist(fullfile(prefdir,'javaclasspath.txt'), 'file') == 2)
                    type='a';
                                    fid = fopen(fullfile(prefdir,'javaclasspath.txt'),'r');
                                    A = fscanf(fid,'%s');
                                                        fclose(fid);
                                   isjavaclasspath= strfind(A,fullfile(prefdir,'portfolioeffect-quant-client-1.0-allinone.jar'));
                    if(~isempty(isjavaclasspath));
                        wr=false;
                    else
                                               wr=true; 
                    end
                else
                    type='w';
                     wr=true; 
                end
                if wr
                fid = fopen(fullfile(prefdir,'javaclasspath.txt'),type);
                if (fid ~= -1)
                    fprintf(fid,'%s\r\n',fullfile(prefdir,'portfolioeffect-quant-client-1.0-allinone.jar'));
                    fclose(fid);
                    fprintf('SUCCESS. Java class path updated.');
                else
                    fprintf('ERROR. Cannot write java class path.');
                    complete = false;
                end
                end
            end
            if(complete)
                fprintf(cat(2,'\n','Setup complete! Restart Matlab session now.','\n',...
                    '+++++++++++++++++++++++++++++++++++++++++++++++++','\n'));
                assert(~result,'Setup complete! Restart Matlab session now.');
            else
                fprintf(cat(2,'\n','Setup failed! Fix errors and try again.','\n',...
                    '+++++++++++++++++++++++++++++++++++++++++++++++++','\n'));
                assert(~result,'Setup failed! Fix errors and try again.');
            end
            result=false;
        end
    end
end
end